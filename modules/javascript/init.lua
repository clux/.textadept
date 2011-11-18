-- Based on Sir Alaran's original JavaScript module
-- Heavily edited by clux


module("_m.javascript", package.seeall)

local m_editing, m_run = _m.textadept.editing, _m.textadept.run

m_editing.comment_string.javascript = "// "
-- Run command (uses file extension).
m_run.run_command.js = 'node %(filename)'
m_run.compile_command.js = 'jslint %(filename)'

-- Sets default buffer properties for JavaScript files. A default indent of
-- 2 spaces is used.
function set_buffer_properties()
  buffer.indent = 2
end

-- Adeptsense
sense = _m.textadept.adeptsense.new("javascript")
sense.ctags_kinds = {
	m = "functions",
	f = "fields",
	c = "classes"
}
sense:load_ctags(_USERHOME.."/modules/javascript/tags", true)
sense:add_trigger(".")
sense.syntax.word_chars = "%w_%$" -- allow dollar sign for jQuery
sense.syntax.symbol_chars = '[%w_%$%.]'

-- Override get_symbol so that adeptsense will show jQuery autocomplete in the
-- following situation:
-- $("#someid").
function sense:get_symbol()
	local char = string.char(buffer.char_at[buffer.current_pos - 2])
	if char == ")" then
		begin = buffer:brace_match(buffer.current_pos - 2)
		if string.char(buffer.char_at[begin - 1]) == "$" then return "jQuery", "" end
	end
	return self.super.get_symbol(sense)
end

-- $ is a common alias for jQuery
function sense:get_class(symbol)
	if symbol == "$" then return "jQuery" else return symbol end
end

-- Load user ctags files
if lfs.attributes(_USERHOME.."/modules/javascript/tags") then
	sense:load_ctags(_USERHOME.."/modules/javascript/tags")
end

-- Snippets
if type(_G.snippets) == "table" then
	_G.snippets.javascript = {
    -- Keys iteration.
    fork = [[
Object.keys(%1(obj)).forEach(function(%2(e)){
  %0
});]],
    -- Each iteration.
    fore = [[
%1(array).forEach(function(%2(e)){
  %0
});]],
    -- Filter array.
    filt = [[
%1(array).filter(function(%2(e)){
  %0
});]],
    -- Object for.
    foro = [[
for (var %1(key) in %2(obj)) {
  %3(if (!Object.prototype.hasOwnProperty.call(%2, %1)) continue;)
  var %4(val) = %2[%1%];
  %0
}]],
    -- Array for.
    fora = [[
for (var %1(i) = %2(0); %1 < %3(ary).length; %1 += %4(1)) {
	var %5(val) = %3[%1%];
  %0
}]],
    -- Range for.
    forr = [[
for (var %1(i) = %2(0); %1 < %3(limit); %1 += %4(1)) {
  %0
}]],
    -- Console.log.
    c = "console.log(%1(\"\"));",
    -- Require.
    r = "require('%1(module)');",
	}
end

-- Keys
_G.keys.javascript = {
  al = {
    m = { io.open_file,
          (_USERHOME..'/modules/javascript/init.lua'):iconv('UTF-8', _CHARSET) },
  },
  [not OSX and 'ci' or 'cesc'] = { sense.complete, sense },
}
