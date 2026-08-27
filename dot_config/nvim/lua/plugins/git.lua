return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        numhl = false,
        linehl = false,
        watch_gitdir = { interval = 1000 }, -- auto-refresh
        attach_to_untracked = true,
      })
    end,
    keys = {
      {
        "<leader>ab",
        function() require("gitsigns").toggle_current_line_blame() end,
        mode = "n",
        desc = "Toggle Git blame",
        noremap = true,
        silent = true,
      }
    }
  },
}
