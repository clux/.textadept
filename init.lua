require 'textadept'

keys.cw = { function()
  if buffer._type then
    buffer:close()
    view:unsplit()
  else
    buffer:close()
  end
end }
