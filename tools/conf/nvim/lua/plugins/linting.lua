return {
  "mfussenegger/nvim-lint",

  event = { "VeryLazy" },

  keys = {
    {
      "<leader>l",
      function()
        require("lint").try_lint()
      end,
      desc = "Run linting for current file",
    },
  },

  opts = {
    events = { "BufEnter", "BufWritePost", "BufReadPost", "InsertLeave" },

    linters_by_ft = {
      bash = { "shellcheck" },
      css = { "stylelint" },
      eruby = { "erb_lint" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      lua = { "luacheck" },
      markdown = { "markdownlint" },
      nix = { "nix" },
      ruby = { "rubocop" },
      sass = { "stylelint" },
      scss = { "stylelint" },
      sh = { "shellcheck" },
      terraform = { "tflint" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    },
  },

  -- Throws error on startup if config isn't defined for this plugin
  config = function() end,
}
