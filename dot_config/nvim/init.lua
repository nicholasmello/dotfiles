vim.opt.mouse = ""

vim.opt.wildmode = "longest,list"

vim.opt.list = true
vim.opt.listchars = "tab:>-,trail:-,extends:#,nbsp:-"

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true  -- case sensitive when uc present
vim.opt.modeline = true   -- Search files for local settings such as nowrap
vim.opt.laststatus = 2    -- Always show the status line at the bottom of the window

vim.opt.colorcolumn = "80"
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 232, bg = "#808080" })

vim.opt.clipboard = "unnamedplus"
vim.wo.relativenumber = true

vim.g.mapleader = ";"

-- Get rid of highlighting with enter
vim.keymap.set("n", "<cr>", "<cmd>noh<cr><cr>")

-- Leader Bindings
vim.g.mapleader = ";"
vim.keymap.set('n', '<leader>tc', '<cmd>tabnew<cr>')
vim.keymap.set('n', '<leader>tn', '<cmd>tabnext<cr>')
vim.keymap.set('n', '<leader>tp', '<cmd>tabprevious<cr>')
vim.keymap.set('n', '<leader>tN', '<cmd>tabprevious<cr>')
vim.keymap.set('n', '<leader>z', '<c-w>|<c-w>_')
vim.keymap.set('n', '<leader><space>', '<c-w>=')
vim.keymap.set('n', '<leader>h', '<c-w>h')
vim.keymap.set('n', '<leader>j', '<c-w>j')
vim.keymap.set('n', '<leader>k', '<c-w>k')
vim.keymap.set('n', '<leader>l', '<c-w>l')

vim.diagnostic.config({
  virtual_text = {
    prefix = '>>', -- or any symbol you prefer
    spacing = 1,
    -- position diagnostics at end of line:
    virt_text_pos = "eol",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

require("bootstrap")  -- Bootstrap lazy.nvim and load all plugins
require("whitespace") -- Adds autocmd to remove whitespace
require("jk")         -- Adds jk escape
