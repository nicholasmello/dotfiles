return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    float = {
      max_width = math.floor(vim.o.columns * 0.6),
      max_height = math.floor(vim.o.lines * 0.6),
      border = "rounded",
    }
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,

  keys = {
    {
      "<leader>e",
      function()
        require("oil").open_float()
      end,
      desc = "Open Oil floating window",
      noremap = true,
      silent = true,
    },
  },
}
