return {
  "dracula/vim",

  lazy = false,
  priority = 1000,

  config = function()
    vim.cmd([[ colorscheme dracula ]])
  end,
}
