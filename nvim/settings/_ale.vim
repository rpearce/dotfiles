""
"" w0rp/ale
""

"let g:ale_lint_on_text_changed = 0
"let g:ale_fixers = {
"\   'javascript': ['prettier'],
"\   'css': ['prettier'],
"\}
"let g:ale_fix_on_save = 1

" Ctrl-k and Ctrl-j for jumping to prev/next errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
