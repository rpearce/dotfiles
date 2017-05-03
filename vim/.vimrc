""
"" Source all our settings
""

for f in split(glob('~/.dotfiles/vim/settings/*.vim'), '\n')
  exe 'source' f
endfor


""
"" Basic Setup
""

color onedark                     " Set the color scheme
set number                        " Show line numbers
set ruler                         " Show line and column number
syntax enable                     " Turn on syntax highlighting allowing local overrides
set guifont=Menlo\ Regular:h14    " Font stuff
set clipboard=unnamed             " Allow for x-app pasting
set termguicolors                 " Use full colors
