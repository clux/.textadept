-- Based on rgieseke's original CoffeeScript module
-- Heavily edited by clux

module('_m.coffeescript', package.seeall)

-- ## Settings

-- Local variables.
local m_editing, m_run = _m.textadept.editing, _m.textadept.run
-- Comment string (uses lexer name).
m_editing.comment_string.coffeescript = '# '
-- Run command (uses file extension).
m_run.run_command.coffee = 'coffee %(filename)'
m_run.compile_command.coffee = 'coffee -pb %(filename)'

-- Sets default buffer properties for CoffeeScript files. A default indent of
-- 2 spaces is used.
function set_buffer_properties()
  buffer.indent = 2
end

-- From here to snippets is generally unmodified - some bits removed only

-- Check the syntax after saving a file using the `--lint` option of the
-- Coffeescript executable. This requires the jsl
-- ([JavaScript Lint](http://www.javascriptlint.com/)) command
-- to be installed.
CHECK_SYNTAX = true

-- ## Commands.

-- Check syntax after file saving.
events.connect(events.FILE_AFTER_SAVE,
  function() -- show syntax errors as annotations
    if CHECK_SYNTAX and buffer:get_lexer() == 'coffeescript' then
      local buffer = buffer
      buffer:annotation_clear_all()
      local filename = buffer.filename:iconv(_CHARSET, 'UTF-8')
      local command = 'coffee -l '..filename
      local p = io.popen(command..' 2>&1')
      local out = p:read('*line')
      p:close()
      local err_msg = out:match("Error.-, (.+)")
      if err_msg then
        local line = err_msg:match('on line (%d+)')
        -- Make sure the first char of the error message is upper case.
        err_msg = (err_msg:sub(1, 1)):upper()..err_msg:sub(2)
        if line then
          line = line - 1 -- Scintilla line numbers start from 0.
          buffer.annotation_visible = 2
          -- If error is off screen, show annotation on the current line.
          if (line < buffer.first_visible_line) or
             (line > buffer.first_visible_line + buffer.lines_on_screen) then
            line = buffer.line_from_position(buffer.current_pos)
          end
          buffer.annotation_style[line] = 8 -- error style number
          buffer:annotation_set_text(line, err_msg)
        end
      end
    end
  end)

-- Control structures after which indentation should be increased. Loops can
-- be used as an expression, so the pattern need to start with a variable name.
local control_structure_patterns = {
  '^%s*class',
  '^%s*%w*%s?=?%s?for',
  '^%s*if',
  '^%s*else',
  '^%s*switch',
  '^%s*when',
  '^%s*%w*%s?=?%s?while',
  '^%s*until',
  '^%s*loop',
  '^%s*try',
  '^%s*catch',
  '^%s*finally',
  '[%-=]>[\r\n]$',
  '[=:][\r\n]$'
}

-- Increase indentation level after new line if line contains `class`,
-- `for`, etc., but only if at the end of a line.
local function indent()
  local buffer = buffer
  if buffer:auto_c_active() then return false end
  local current_pos = buffer.current_pos
  local line_num = buffer:line_from_position(current_pos)
  local col = buffer.column[current_pos]
  if col == 0 or buffer.current_pos ~= buffer.line_end_position[line_num] then
    return false
  end
  local line = buffer:get_line(line_num)
  local line_indentation = buffer.line_indentation
  for _, patt in ipairs(control_structure_patterns) do
    if line:find(patt) then
      local indent = line_indentation[line_num]
      buffer:begin_undo_action()
      buffer:new_line()
      line_indentation[line_num + 1] = indent + buffer.indent
      buffer:line_end()
      buffer:end_undo_action()
      return true
    end
  end
  return false
end

-- Insert clipboard content enclosed in backticks for raw JavaScript.
function insert_raw_js(args)
  local buffer = buffer
  buffer:begin_undo_action()
  buffer:add_text('``')
  buffer:char_left()
  buffer:paste()
  buffer:char_right()
  buffer:end_undo_action()
end

-- Insert [heredoc](http://jashkenas.github.com/coffee-script/#strings).<br>
-- Parameter:<br>
-- _char_: `"`, `'` or `#`
function insert_heredoc(char)
  local buffer = buffer
  buffer:begin_undo_action()
  local current_pos = buffer.current_pos
  local indentation = buffer.column[current_pos]
  local space = string.rep(" ", indentation)
  buffer:add_text(char:rep(3).."\n"..space.."\n"..space..char:rep(3))
  buffer:line_up()
  buffer:end_undo_action()
end


-- ## Snippets.

-- Container for Coffeescript-specific snippets.
if type(_G.snippets) == 'table' then
  _G.snippets.coffeescript = {
    -- Bound function.
    bf = "%1((%2(args)) )=>\n\t%0",
    -- Class.
    cla = [[
class %1(ClassName)%2( extends %3(Ancestor))
	%4(constructor: (%5(args)) ->
		%6(# body...))
	%0]],
    -- Else if.
    elif = "else if %1(cond)\n\t",
    -- Function (Named).
    fn = [[
%1(name) = (%2(args)) ->
	%0]],
    -- Function (Anonymous).
    f = "%1((%2(args)) )->\n\t%0",
    -- If ... else.
    ife = [[
if %1(cond)
	%2
else
	%0]],
    -- If.
    ['if'] = [[
if %1(cond)
	%0]],
  -- Keys iteration.
  fork = "Object.keys(%1(obj)).forEach ",
  -- Each iteration.
  fore = "%1(array).forEach ",
  -- Filter array.
  filt = "%1(array).filter ",
  -- Array comprehension.
  fora = "for %1(name) in %2(array)\n\t%0",
  -- Object comprehension.
  foro = "for %1(key),%2(val) of %3(obj)\n\t%0",
  -- Range comprehension (excludes end).
  forr = [[
for %1(name) in [%2(0)...%3(len)]%4( by %5(step))
	%0]],
  -- Switch.
  sw = [[
switch %1(val)
	when %2(cond)
		%0]],
  -- Ternary if.
  ['?'] = "if %1(cond) then %2(val) else %0",
  -- Throw new Error.
  t = "throw new Error(\"%0\")",
  -- Try ... catch.
  tc = [[
try
	%1
catch %2(e)
	%0]],
  -- Unless.
  u = "%1(action) unless %0",
  -- Console.log.
  c = "console.log",
  -- Require.
  r = "require('%1(name)')",
  }
end
