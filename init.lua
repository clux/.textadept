require 'textadept'


keys.cw = { function()
  if buffer._type then
    buffer:close()
    gui.goto_view(-1, true)
    view:unsplit()
  else
    buffer:close()
  end
end }

