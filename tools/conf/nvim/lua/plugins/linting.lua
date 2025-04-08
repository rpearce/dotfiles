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
      elixir = { "mix" },
      eruby = { "erb_lint" },
      go = { "golangcilint" },
      haskell = { "hlint" },
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

  config = function(_, opts)
    local lint = require("lint")

    -- Apply linters_by_ft from opts
    lint.linters_by_ft = opts.linters_by_ft

    -- Setup golangci-lint
    local golangcilint = require("lint.linters.golangcilint")
    golangcilint.append_fname = true
    golangcilint.args = {
      "run",
      "--out-format",
      "json",
    }

    -- Auto lint on desired events
    vim.api.nvim_create_autocmd(opts.events, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
