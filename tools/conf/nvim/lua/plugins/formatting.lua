return {
  "stevearc/conform.nvim",

  event = { "BufWritePre" },

  keys = {
    {
      "<leader>mp",
      function()
        require("conform").format({
          async = false,
        })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },

  opts = {
    formatters_by_ft = {
      css = { "prettier" },
      ejs = { "prettier" },
      go = { "gofumpt", lsp_format = "fallback" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier" },
      rust = { "rustfmt" },
      sass = { "prettier" },
      scss = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      yaml = { "prettier" },
    },
    format_on_save = {
      timeout_ms = 500,
    },
  },
}
