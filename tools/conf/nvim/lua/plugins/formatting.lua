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
      go = { "gofumpt", lsp_format = "fallback" },
      lua = { "stylua" },
      rust = { "rustfmt" },
    },
    format_on_save = {
      timeout_ms = 500,
    },
  },
}
