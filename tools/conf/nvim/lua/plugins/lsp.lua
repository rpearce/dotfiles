return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup()

      require("mason-tool-installer").setup({
        ensure_installed = {
          "astro-language-server",
          "bash-language-server",
          "css-lsp",
          "dockerfile-language-server",
          "elixir-ls",
          "eslint-lsp",
          "gopls",
          "html-lsp",
          "json-lsp",
          "lua-language-server",
          "rust-analyzer",
          "typescript-language-server",
          -- Tools
          "gofumpt",
          "hlint",
          "markdownlint",
          "ormolu",
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
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
    },

    keys = {
      { "[d", vim.diagnostic.goto_prev, desc = "Goto previous diagnostic" },
      { "]d", vim.diagnostic.goto_next, desc = "Goto next diagnostic" },
      {
        "[e",
        function()
          vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Goto previous error",
      },
      {
        "]e",
        function()
          vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Goto next error",
      },
      {
        "[w",
        function()
          vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
        end,
        desc = "Goto previous warning",
      },
      {
        "]w",
        function()
          vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
        end,
        desc = "Goto next warning",
      },
      { "gc", vim.lsp.buf.code_action, desc = "List code actions" },
      { "gd", vim.lsp.buf.definition, desc = "Goto definition" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto declaration" },
      { "gi", vim.lsp.buf.implementation, desc = "Goto implementation" },
      { "go", vim.lsp.buf.type_definition, desc = "Goto type definition" },
      { "gr", vim.lsp.buf.references, desc = "List all references" },
      { "gs", vim.lsp.buf.signature_help, desc = "View signature info" },
    },

    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Global defaults
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- ESLint with format on save
      vim.lsp.config("eslint", {
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.code_action({
                context = { only = { "source.fixAll.eslint" } },
                apply = true,
              })
            end,
          })
        end,
      })

      -- Lua with vim global
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      -- TypeScript with inlay hints for both TS and JS
      vim.lsp.config("ts_ls", {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
            },
          },
        },
      })

      -- Enable servers
      local servers = {
        "astro",
        "bashls",
        "cssls",
        "dockerls",
        "elixirls",
        "eslint",
        "gopls",
        "html",
        "jsonls",
        "lua_ls",
        "rust_analyzer",
        "ts_ls",
      }

      for _, server in ipairs(servers) do
        vim.lsp.enable(server)
      end
    end,
  },
}

