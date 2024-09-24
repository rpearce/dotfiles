local globals = {
  mapleader = " ",
  maplocalleader = "\\",
}

local options = {
  clipboard = "unnamedplus", -- use the clipboard register for all operations except yank
  colorcolumn = "80", -- visual line at column N
  expandtab = true, -- convert tabs to spaces
  fileencoding = "utf-8", -- the encoding written to a file
  hidden = true, -- hide buffers instead of removing them
  hlsearch = true, -- highlight matches
  ignorecase = true, -- searches are case insensitive (unless smartcase is on)
  incsearch = true, -- incremental searching
  list = true, -- show invisible characters
  mouse = "a", -- allow the mouse to be used in neovim
  number = true, -- show line numbers
  ruler = true, -- show line and column number
  shiftwidth = 2, -- an autoindent (with <<) is two spaces
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  smartcase = true, -- searches are case insensitive unless they contain at least one capital letter
  smartindent = true, -- make indenting smarter again
  swapfile = true, -- creates a swapfile
  tabstop = 2, -- a tab is N spaces
  termguicolors = true, -- Enables 24-bit RGB color in the TUI
  textwidth = 80, -- max suggested text width
  undofile = true, -- enable persistent undo
  updatetime = 100, -- faster completion (4000ms default)
  wrap = false, -- don't wrap lines
}

for name, value in pairs(globals) do
  vim.g[name] = value
end

for name, value in pairs(options) do
  vim.opt[name] = value
end
