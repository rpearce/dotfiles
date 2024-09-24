return {
  {
    "dracula/vim",

    lazy = false,
    priority = 1000,

    config = function()
      vim.cmd([[ colorscheme dracula ]])
    end,
  },

  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon", -- moon, storm, night, day
    },
  },

  {
    "shaunsingh/nord.nvim",
  },

  {
    "shaunsingh/moonlight.nvim",
  },
}
