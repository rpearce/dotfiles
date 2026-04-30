local parsers = {
  "astro",
  "bash",
  "c",
  "css",
  "dockerfile",
  "elixir",
  "embedded_template",
  "haskell",
  "heex",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "ruby",
  "rust",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

local filetypes = {
  "astro",
  "bash",
  "c",
  "css",
  "dockerfile",
  "elixir",
  "eelixir",
  "eruby",
  "haskell",
  "heex",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "python",
  "query",
  "ruby",
  "rust",
  "sh",
  "typescript",
  "typescriptreact",
  "vim",
  "help",
  "yaml",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
