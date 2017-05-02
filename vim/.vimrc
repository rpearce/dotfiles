call plug#begin('~/.vim/plugged')
" Themes
Plug 'joshdick/onedark.vim'

" Tools
Plug 'mileszs/ack.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ElmCast/elm-vim'
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'
Plug 'mxw/vim-jsx'
Plug 'vim-syntastic/syntastic'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'elzr/vim-json'
Plug 'terryma/vim-multiple-cursors'
Plug 'MarcWeber/vim-addon-mw-utils' " required for vim-snipmate
Plug 'tomtom/tlib_vim' " required for vim-snipmate
Plug 'ap/vim-css-color'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'garbas/vim-snipmate'
Plug 'bronson/vim-trailing-whitespace'
Plug 'skalnik/vim-vroom'

" Languages
Plug 'kchmck/vim-coffee-script'
Plug 'chrisbra/csv.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'jimenezrick/vimerl'
Plug 'tpope/vim-git'
Plug 'fatih/vim-go'
Plug 'tpope/vim-haml'
Plug 'wlangstroth/vim-haskell'
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
Plug 'tpope/vim-markdown'
Plug 'sunaku/vim-ruby-minitest'
Plug 'mustache/vim-mustache-handlebars'
Plug 'mmalecki/vim-node.js'
Plug 'tpope/vim-rails'
Plug 'skwp/vim-rspec'
Plug 'vim-ruby/vim-ruby'
Plug 'derekwyatt/vim-scala'
Plug 'cakebaker/scss-syntax.vim'
Plug 'leafgarland/typescript-vim'
call plug#end()

" Set the color scheme
color onedark

" Force some filetypes to load
au BufRead,BufNewFile *.jbuilder set filetype=ruby
au BufRead,BufNewFile *.ejs set filetype=javascript

" NERD Tree
let NERDTreeHijackNetrw = 0
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o$', '\~$']

map <leader>n :NERDTreeToggle<CR>:NERDTreeMirror<CR>

augroup AuNERDTreeCmd
autocmd AuNERDTreeCmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd AuNERDTreeCmd FocusGained * call s:UpdateNERDTree()

" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . fnameescape(a:directory)
  endif

  " Allows reading from stdin
  " ex: git diff | mvim -R -
  if strlen(a:directory) == 0
    return
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif
endfunction

" CTRLP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$|bower_components|node_modules',
  \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
  \ }

" Syntastic
let g:syntastic_mode_map = {'mode': 'passive'}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_warning_symbol = 'W>'
let g:syntastic_error_symbol = 'E>'
let g:syntastic_style_warning_symbol = 'W}'
let g:syntastic_style_error_symbol = 'E}'
let g:syntastic_stl_format = '[%E{E:%e(#%fe)}%B{,}%W{W:%w(#%fw)}]'

" Elm
let g:elm_classic_hightlighting = 0
let g:elm_format_autosave = 1

" JSX
let g:jsx_ext_required = 0

set wildignore+=*/node_modules/*,*/log/*,*/tmp/*
set hidden
set guifont=Menlo\ Regular:h14
set clipboard=unnamed
set termguicolors
