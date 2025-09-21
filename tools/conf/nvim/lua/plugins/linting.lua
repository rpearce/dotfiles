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
      javascript = { "eslint_d", "prettier" },
      javascriptreact = { "eslint_d", "prettier" },
      lua = { "luacheck" },
      markdown = { "markdownlint" },
      nix = { "nix" },
      ruby = { "rubocop" },
      sass = { "stylelint" },
      scss = { "stylelint" },
      sh = { "shellcheck" },
      -- terraform = { "tflint" },
      typescript = { "eslint_d", "prettier" },
      typescriptreact = { "eslint_d", "prettier" },
    },
  },

  config = function(_, opts)
    local lint = require("lint")

    -- Add "-x" to shellcheck flags
    lint.linters.shellcheck.args = lint.linters.shellcheck.args or {}
    table.insert(lint.linters.shellcheck.args, 1, "-x")

    -- Filter out unavailable linters
    local available_linters = {}
    for ft, linters in pairs(opts.linters_by_ft) do
      available_linters[ft] = {}
      for _, linter in ipairs(linters) do
        if vim.fn.executable(linter) == 1 then
          table.insert(available_linters[ft], linter)
        end
      end
    end

    lint.linters_by_ft = available_linters

    -- Setup luacheck to use the config file
    local luacheck = require("lint.linters.luacheck")
    luacheck.args = {
      "--config", vim.fn.stdpath("config") .. "/.luacheckrc",
      "--formatter", "plain",
      "--codes",
      "--ranges",
      "-"
    }

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
