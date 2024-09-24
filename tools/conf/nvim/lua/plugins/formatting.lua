return {
  "stevearc/conform.nvim",

  event = { "BufWritePre" },

  keys = {
    {
      "<leader>mp",
      function()
        require("conform").format({
          async = false,
          -- lsp_format = "fallback",
        })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },

  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
    },
    format_on_save = {
      timeout_ms = 500,
      -- lsp_format = "fallback",
    },
  },
}
