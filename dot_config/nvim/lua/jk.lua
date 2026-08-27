local timer = nil
local waiting_for_k = false

local function cancel_timer()
  if timer then
    timer:stop()
    timer:close()
    timer = nil
  end
  waiting_for_k = false
end

vim.keymap.set({"i", "t"}, "j", function()
  if waiting_for_k then
    return "j"
  end

  waiting_for_k = true

  local timeout = vim.o.timeoutlen
  timer = vim.loop.new_timer()
  timer:start(timeout, 0, vim.schedule_wrap(function()
    cancel_timer()
  end))

  return "j"
end, { expr = true, noremap = true })

vim.keymap.set({"i", "t"}, "k", function()
  if waiting_for_k then
    cancel_timer()
    return "<BS><ESC>"
  else
    return "k"
  end
end, { expr = true, noremap = true })
