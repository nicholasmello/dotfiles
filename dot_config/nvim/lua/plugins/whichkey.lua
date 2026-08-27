return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    triggers = { "<leader>", " " },
    defaults = {
      ["<leader>d"] = { name = "+LSP" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
