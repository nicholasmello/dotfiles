-- RemoveWhitespace
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("RemoveWhitespace", { clear = true }),
  pattern = "*", -- Handle pattern myself in callback
  callback = function()
    if vim.bo.filetype == "diff" then
      return
    end
    -- Failure to find is not a real failure, silence failures
    vim.api.nvim_command("silent! " .. "%s/\\s\\+$//")
  end,
})
