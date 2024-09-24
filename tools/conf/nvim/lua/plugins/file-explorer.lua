return {
  "nvim-neo-tree/neo-tree.nvim",

  branch = "v3.x",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },

  keys = {
    { "<leader>n", "<cmd>Neotree toggle<cr>", desc = "Neotree toggle" },
    { "<leader>b", "<cmd>Neotree toggle show buffers right<cr>", desc = "Neotree show buffers on right side" },
  },

  opts = {
    filesystem = {
      follow_current_file = { enabled = true },
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      hijack_netrw_behavior = "open_current",
    },
    popup_border_style = "single",
  },
}
