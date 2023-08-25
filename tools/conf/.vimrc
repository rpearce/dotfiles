""
"" Plugins
""

source ~/.config/nvim/vim-plugins.vim


""
"" Basic Setup
""

syntax on
syntax enable                     " Turn on syntax highlighting allowing local overrides
" set guifont=Monaco\ Regular:h12   " Font stuff
set hidden                        " hide buffers instead of removing them
set number                        " Show line numbers
set ruler                         " Show line and column number
set clipboard=unnamed             " Allow for x-app pasting

""
"" colors
""

if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

colorscheme dracula


""
"" ale (linting)
""

"let g:ale_javascript_eslint_executable = 'eslint'
"let g:ale_javascript_eslint_use_global = 0
"let g:ale_lint_on_text_changed = 0

"let g:ale_javascript_eslint_use_global = 1
"let g:ale_javascript_eslint_executable = 'yarn'
"let g:ale_javascript_eslint_options = 'run eslint'

let g:ale_completion_enabled = 0
let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 1
"let g:ale_rust_analyzer_executable = '~/.nix-profile/bin/rust-analyzer'
"let g:ale_rust_analyzer_config = {
"\  'rust': {
"\    'all_targets': 1,
"\    'build_on_save': 1,
"\  }
"\}

let g:ale_linters = {}
"let g:ale_linters.rust = ['analyzer', 'cargo', 'rustc']

let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_fixers.c = ['clangtidy']
let g:ale_fixers.cpp = ['clangtidy']
let g:ale_fixers.css = ['eslint']
let g:ale_fixers.javascript = ['eslint']
let g:ale_fixers.rust = ['rustfmt']

" Ctrl-k and Ctrl-j for jumping to prev/next errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


""
"" coc-nvim
""


set cmdheight=2    " Give more space for displaying messages.
set updatetime=300 " Less delay

" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions
let g:coc_global_extensions = []
let g:coc_global_extensions += ['coc-clangd']
let g:coc_global_extensions += ['coc-css']
let g:coc_global_extensions += ['coc-elixir']
let g:coc_global_extensions += ['coc-eslint']
let g:coc_global_extensions += ['coc-go']
let g:coc_global_extensions += ['coc-highlight']
let g:coc_global_extensions += ['coc-html']
let g:coc_global_extensions += ['coc-json']
let g:coc_global_extensions += ['coc-markdownlint']
let g:coc_global_extensions += ['coc-rust-analyzer']
let g:coc_global_extensions += ['coc-sh']
let g:coc_global_extensions += ['coc-sql']
let g:coc_global_extensions += ['coc-svg']
let g:coc_global_extensions += ['coc-tsserver']
let g:coc_global_extensions += ['coc-yaml']

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

" https://github.com/neoclide/coc.nvim/issues/2521#issuecomment-717460648
nnoremap <silent><expr> <C-d> coc#float#scroll(1, 1)
nnoremap <silent><expr> <C-u> coc#float#scroll(0, 1)
inoremap <silent><expr> <C-d> "\<c-r>=coc#float#scroll(1, 1)\<cr>"
inoremap <silent><expr> <C-u> "\<c-r>=coc#float#scroll(0, 1)\<cr>"
vnoremap <silent><expr> <C-d> coc#util#float_scroll_i( 1)
vnoremap <silent><expr> <C-u> coc#util#float_scroll_i(-1)


""
"" rustfmt
""

let g:rustfmt_autosave = 1


""
"" CTRLP
""

"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_show_hidden = 1
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/]\.(git|hg|svn)$|bower_components|node_modules|coverage',
"  \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
"  \ }

"if executable('rg')
"  set grepprg=rg\ --color=never\ --no-heading\ --smart-case\ --vimgrep
"  "set grepformat=%f:%l:%c:%m
"  let g:ctrlp_user_command = 'rg %s --color=never --files --glob ""'
"  let g:ctrlp_use_caching = 0
"else
"  let g:ctrlp_clear_cache_on_exit = 0
"endif


""
"" Elm
""

let g:elm_classic_hightlighting = 0
let g:elm_format_autosave = 1

" Whitespace

autocmd FileType elm set tabstop=4
autocmd FileType elm set shiftwidth=4


""
"" Haskell
""

filetype plugin indent on                 " recommended from https://github.com/neovimhaskell/haskell-vim

let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_classic_highlighting = 0    " to enable classic highlighting
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_indent_disable = 1          " to disable haskell-vim indentation

" Whitespace

autocmd FileType haskell set tabstop=4
autocmd FileType haskell set softtabstop=2
autocmd FileType haskell set shiftwidth=2
autocmd FileType haskell set shiftround


""
"" HTML
""

autocmd FileType html set tabstop=2
autocmd FileType html set shiftwidth=2


""
"" TypeScript
""

" Whitespace

autocmd FileType typescript set tabstop=2
autocmd FileType typescript set shiftwidth=2


""
"" Files
""

" In Makefiles, use real tabs, not tabs expanded to spaces
au FileType make setlocal noexpandtab

" Force some file types to load
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake,*.jbuilder} set filetype=ruby
au BufRead,BufNewFile *.{ejs,mjs} set filetype=javascript
au BufRead,BufNewFile *.{md,mdx,markdown,mdown,mkd,mkdn,txt} set filetype=markdown formatoptions+=t

" make Python follow PEP8 for whitespace ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python setlocal tabstop=4 shiftwidth=4

" Remember last location in file, but not for commit messages.
" see :help last-position-jump
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g`\"" | endif


""
"" JSX
""

let g:jsx_ext_required = 0


""
"" Markdown
""

let g:vim_markdown_folding_disabled = 1


""
"" General Mappings (Normal, Visual, Operator-pending)
""

" Toggle paste mode
"nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
"imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
nmap <leader>ew :e <C-R>=expand('%:h').'/'<cr>
nmap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
nmap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>
nmap <leader>et :tabe <C-R>=expand('%:h').'/'<cr>

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nmap <silent> <leader>ul :t.<CR>Vr=

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Map command-[ and command-] to indenting or outdenting
" while keeping the original selection in visual mode
vmap <A-]> >gv
vmap <A-[> <gv

nmap <A-]> >>
nmap <A-[> <<

omap <A-]> >>
omap <A-[> <<

imap <A-]> <Esc>>>i
imap <A-[> <Esc><<i

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
"nmap <C-k> [e
"nmap <C-j> ]e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
"vmap <C-k> [egv
"vmap <C-j> ]egv

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Map Control-# to switch tabs
map  <C-0> 0gt
imap <C-0> <Esc>0gt
map  <C-1> 1gt
imap <C-1> <Esc>1gt
map  <C-2> 2gt
imap <C-2> <Esc>2gt
map  <C-3> 3gt
imap <C-3> <Esc>3gt
map  <C-4> 4gt
imap <C-4> <Esc>4gt
map  <C-5> 5gt
imap <C-5> <Esc>5gt
map  <C-6> 6gt
imap <C-6> <Esc>6gt
map  <C-7> 7gt
imap <C-7> <Esc>7gt
map  <C-8> 8gt
imap <C-8> <Esc>8gt
map  <C-9> 9gt
imap <C-9> <Esc>9gt

" After whitespace, insert the current directory into a command-line path
cnoremap <expr> <C-P> getcmdline()[getcmdpos()-2] ==# ' ' ? expand('%:p:h') : "\<C-P>"


""
"" NERD Tree
""

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


""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

" Text search
nmap <leader>g :Rg<cr>

" File search
nmap <leader>f :Files ./<cr>


""
"" Status Line
""

" always show the status bar
set laststatus=2

" start the status line
set statusline=%f\ %m\ %r
set statusline+=Line:%l/%L[%p%%]
set statusline+=Col:%v
set statusline+=Buf:#%n
set statusline+=[%b][0x%B]


""
"" Whitespace
""

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set textwidth=80                  " max suggested text width
set colorcolumn=80                " visual line at column 80
set list                          " show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode
set nofixendofline                " don't automatically add new line to end of files

" List chars
set listchars=""                  " reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen


" Tabular plugin
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a=> :Tabularize /=><CR>
vmap <Leader>a=> :Tabularize /=><CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>


""
"" Wild Ignore
""

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Ignore librarian-chef, vagrant, test-kitchen and Berkshelf cache
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*

" Ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

" Disable node_modules, log and tmp
set wildignore+=*/node_modules/*,*/log/*,*.log,*/tmp/*

" Disable stack build files
set wildignore+=*/.stack-work/*
