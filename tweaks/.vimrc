" This is my minimalistic vim-config
"
" HOWTO: copy it to your home-directory to use it. Further more, you can use
" following plugin: "./.vim/plugin/bad-whitespaces.vim". Additionally it uses
" fugitive for git status and syntastic for linting.
"
"    ^   ^
"  +-------+
"  |  o_O  |
"  |  >.<  |__/
"  +-------+

set tabstop=4 softtabstop=4 expandtab
set noautoindent
set hlsearch

"hi CursorLine cterm=none ctermbg=NONE ctermfg=7
"hi CursorLine cterm=NONE ctermfg=NONE ctermbg=NONE
"set cursorline

" set visual line (Markierungen)
hi Visual term=reverse cterm=NONE ctermbg=15

" show statusline always
set laststatus=2

" show git status via fugitive and more in statusline
set statusline=\ %n\ %v\ %l\/%L
set statusline+=\ %y\ %{strlen(&fenc)?&fenc:&enc}
set statusline+=\ %f%m%r%h%w
set statusline+=\ %{fugitive#statusline()}

" linter
set statusline+=\ %#warningmsg#
set statusline+=\ %{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0
let g:syntastic_enable_r_lintr_checker=1

let g:syntastic_r_checkers= ['lintr']

hi StatusLine cterm=NONE ctermbg=NONE ctermfg=7

hi TabLineFill cterm=NONE ctermbg=NONE ctermfg=NONE
hi TabLine cterm=NONE ctermbg=NONE ctermfg=7
hi TabLineSel ctermbg=NONE ctermfg=12

"hi Title ctermbg=NONE ctermfg=7

" shortcut to erase bad whitepaces and tabs
ca ebw EraseBadWhitespace

" always prefer settings the original author of a file has choosen
setglobal modeline
