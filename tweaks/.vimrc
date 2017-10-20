" This is my minimalistic vim-config
"
" HOWTO: copy it to your home-directory to use it. Further more, you can use
" following plugin: "./.vim/plugin/bad-whitespaces.vim". Additionally it uses
" fugitive for git status.
"
"    ^   ^
"  +-------+
"  |  o_O  |
"  |  >.<  |__/
"  +-------+

set tabstop=4 softtabstop=4 expandtab
set noautoindent
set hlsearch

hi CursorLine cterm=NONE ctermfg=NONE ctermbg=236
set cursorline

" show statusline always
set laststatus=2

" show git status via fugitive and more in statusline
set statusline=\ %n\ %v\ %l\/%L
set statusline+=\ %y\ %{strlen(&fenc)?&fenc:&enc}
set statusline+=\ %F%m%r%h%w
set statusline+=\ %{fugitive#statusline()}

hi StatusLine cterm=NONE ctermbg=236 ctermfg=7

hi TabLineFill ctermfg=236 ctermbg=0
hi TabLine cterm=NONE ctermfg=7 ctermbg=236
hi TabLineSel ctermfg=15 ctermbg=236

hi Title ctermfg=236 ctermbg=15

" shortcut to erase bad whitepaces and tabs
ca ebw EraseBadWhitespace

" always prefer settings the original author of a file has choosen
setglobal modeline
