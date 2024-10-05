return {
  {
    "williamboman/mason.nvim",

    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },

    config = function()
      require("mason").setup()

      require("mason-lspconfig").setup({
        automatic_installation = true,

        ensure_installed = {
          "bashls",
          --"clangd",
          "cssls",
          "dockerls",
          --"erlangls",
          "elixirls",
          "eslint",
          "gopls",
          --"hls",
          "html",
          "jsonls",
          "lua_ls",
          --"nix_ls",
          "rust_analyzer",
          --"ruby_lsp",
          "ts_ls",
        },
      })

      require("mason-tool-installer").setup({
        ensure_installed = {
          "bash-language-server",
          "eslint_d",
          "gofumpt",
          "markdownlint",
          "shellcheck",
          "shfmt",
          "stylua",
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",

    event = { "BufReadPre", "BufNewFile" },

    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
    },

    keys = {
      { "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Goto previous diagnostic" } },
      { "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Goto next diagnostic" } },
      {
        "[e",
        "<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity['ERROR'] })<cr>",
        { desc = "Goto previous error" },
      },
      {
        "]e",
        "<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity['ERROR'] })<cr>",
        { desc = "Goto next error" },
      },
      {
        "[w",
        "<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity['WARN'] })<cr>",
        { desc = "Goto previous warning" },
      },
      {
        "]w",
        "<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity['WARN'] })<cr>",
        { desc = "Goto next warning" },
      },
      { "gc", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "List code actions" } },
      { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Goto definition" } },
      { "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { desc = "Goto declaration" } },
      { "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { desc = "Goto implementation" } },
      { "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", { desc = "Goto type definition" } },
      { "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { desc = "List all references" } },
      { "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { desc = "View signature info" } },
    },

    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = cmp_nvim_lsp.default_capabilities()

      mason_lspconfig.setup_handlers({
        bashls = function()
          lspconfig.bashls.setup({
            capabilities = capabilities,
          })
        end,

        cssls = function()
          lspconfig.cssls.setup({
            capabilities = capabilities,
          })
        end,

        dockerls = function()
          lspconfig.dockerls.setup({
            capabilities = capabilities,
          })
        end,

        elixirls = function()
          lspconfig.elixirls.setup({
            capabilities = capabilities,
          })
        end,

        eslint = function()
          lspconfig.eslint.setup({
            capabilities = capabilities,
          })
        end,

        gopls = function()
          lspconfig.gopls.setup({
            capabilities = capabilities,
          })
        end,

        html = function()
          lspconfig.html.setup({
            capabilities = capabilities,
          })
        end,

        jsonls = function()
          lspconfig.jsonls.setup({})
        end,

        lua_ls = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = {
                    "vim",
                  },
                },
              },
            },
          })
        end,

        rust_analyzer = function()
          lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
          })
        end,

        ts_ls = function()
          local inlayHints = {
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includePropertyDeclarationTypeHints = true,
          }

          lspconfig.ts_ls.setup({
            capabilities = capabilities,
            settings = {
              typescript = {
                inlayHints,
              },
              javascript = {
                inlayHints,
              },
            },
          })
        end,
      })
    end,
  },
}
