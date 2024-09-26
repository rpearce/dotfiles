return {
  "nvim-telescope/telescope.nvim",

  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",

  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
    { "<leader>fs", "<cmd>Telescope git_status<cr>", desc = "Telescope git status" },
    { "<leader>fc", "<cmd>Telescope git_commits<cr>", desc = "Telescope git commits" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
    { "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Telescope diagnostics (current buffer)" },
    { "<leader>fD", "<cmd>Telescope diagnostics<cr>", desc = "Telescope diagnostics (all buffers)" },
  },
}
