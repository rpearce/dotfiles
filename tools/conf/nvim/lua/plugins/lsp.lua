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
          "eslint_d",
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
            -- root_dir = lspconfig.util.root_pattern(
            -- 	".eslintrc",
            -- 	".eslintrc.cjs",
            -- 	".eslintrc.js",
            -- 	".eslintrc.json",
            -- 	"eslint.config.js"
            -- ),
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
              -- implicitProjectConfiguration = {
              --   checkJs = false,
              -- },
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
