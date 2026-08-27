vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format()
  end,
})

return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    keys = {
      -- Navigation
      { "<leader>dgd",   vim.lsp.buf.definition,       desc = "Go to Definition" },
      { "<leader>dgD",   vim.lsp.buf.declaration,      desc = "Go to Declaration" },
      { "<leader>dgi",   vim.lsp.buf.implementation,   desc = "Go to Implementation" },
      { "<leader>dgt",   vim.lsp.buf.type_definition,  desc = "Go to Type Definition" },
      { "<leader>dgr",   vim.lsp.buf.references,       desc = "List References" },
      { "<leader>dgs",   vim.lsp.buf.document_symbol,  desc = "Document Symbols" },
      { "<leader>dgS",   vim.lsp.buf.workspace_symbol, desc = "Workspace Symbols" },

      -- Hover & help
      { "<leader>dgh",   vim.lsp.buf.hover,            desc = "Hover Documentation" },
      { "<leader>dgsig", vim.lsp.buf.signature_help,   desc = "Signature Help" },

      -- Refactoring
      { "<leader>drn",   vim.lsp.buf.rename,           desc = "Rename Symbol" },
      { "<leader>dca",   vim.lsp.buf.code_action,      desc = "Code Action" },
      {
        "<leader>doi",
        function()
          vim.lsp.buf.code_action({
            context = {
              only = { "source.organizeImports" },
              diagnostics = {},
            }
          })
        end,
        desc = "Organize Imports"
      },

      -- Diagnostics
      { "<leader>de",  vim.diagnostic.open_float,                           desc = "Show Line Diagnostics" },
      { "<leader>ddl", vim.diagnostic.setloclist,                           desc = "List Diagnostics" },

      -- Formatting
      { "<leader>df",  function() vim.lsp.buf.format({ async = true }) end, desc = "Format Document" },

      -- Advanced: highlight usage
      { "<leader>dhl", vim.lsp.buf.document_highlight,                      desc = "Highlight Symbol" },
      { "<leader>dhc", vim.lsp.buf.clear_references,                        desc = "Clear Highlights" },
    },
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      vim.lsp.config('lua_ls', {})

      vim.lsp.config('pyright', {})

      vim.lsp.config('bashls', {})

      vim.lsp.config('fish_lsp', {})

      vim.lsp.config('rust_analyzer', {
        root_dir = function(fname)
          -- Look for Cargo.toml to define project root
          return vim.lsp.config().util.root_pattern("Cargo.toml")(fname)
        end,
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" }, -- Run linter
          }
        }
      })
    end,
  },
  {
    -- Quickly install LSPs with internet connection
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^7', -- Recommended
    lazy = false, -- This plugin is already lazy
  }
}
