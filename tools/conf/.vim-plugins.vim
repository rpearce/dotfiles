"""
""" Vim Plug Setup
""

" https://github.com/junegunn/vim-plug/issues/1062#issuecomment-1115224145
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif

"""
""" Vim Plugins
"""

call plug#begin($XDG_DATA_HOME."/nvim/plugins")

" Themes
Plug 'dracula/vim'
Plug 'joshdick/onedark.vim'
Plug 'shaunsingh/moonlight.nvim'
Plug 'shaunsingh/nord.nvim'

" Coq
" Plug 'ms-jpq/coq_nvim'
" Plug 'whonore/Coqtail'

" Syntax highlighting
Plug 'ap/vim-css-color'                           " Preview colours in source code while editing
Plug 'sheerun/vim-polyglot', { 'tag': 'v4.17.0' } " Language pack. Something is wrong with v4.17.1

" Git
Plug 'airblade/vim-gitgutter', {'branch': 'main'} " Show git diff markers in columns
" Plug 'tpope/vim-fugitive' " Git inside vim

" Misc
Plug 'dense-analysis/ale'                       " Lint runner
Plug 'godlygeek/tabular'                        " Text filtering and alignment
Plug 'ctrlpvim/ctrlp.vim'                       " Fuzzy file finding
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Extension host for language servers
Plug 'preservim/nerdcommenter'                  " Commenting++
Plug 'junegunn/fzf'                             " Honestly, to get :Rg for ripgrep to search files
Plug 'junegunn/fzf.vim'                         " ^
Plug 'preservim/nerdtree'                       " Tree explorer
Plug 'tpope/vim-surround'                       " Wrap code with other code
Plug 'ryanoasis/vim-devicons'                   " File type icons
" Plug 'jeetsukumaran/vim-buffergator' " List, select and switch between buffers

call plug#end()
