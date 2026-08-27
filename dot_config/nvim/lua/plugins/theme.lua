return {
  "ellisonleao/gruvbox.nvim",
  config = function()
    vim.g.gruvbox_contrast_dark = "hard"
    vim.g.gruvbox_italic = 1
    vim.g.gruvbox_bold = 1

    vim.cmd("colorscheme gruvbox")
  end,
}
