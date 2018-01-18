""
"" Files
""

" In Makefiles, use real tabs, not tabs expanded to spaces
au FileType make setlocal noexpandtab

" Force some file types to load
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake,*.jbuilder} set filetype=ruby
au BufRead,BufNewFile *.ejs set filetype=javascript
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} set filetype=markdown textwidth=80 formatoptions+=t colorcolumn=80 expandtab

" make Python follow PEP8 for whitespace ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python setlocal tabstop=4 shiftwidth=4

" Remember last location in file, but not for commit messages.
" see :help last-position-jump
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g`\"" | endif
