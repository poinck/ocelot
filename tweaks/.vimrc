" This is my minimalistic vim-config
"
" HOWTO: copy it to your home-directory to use it. Further more, you need
" following plugin: "./.vim/plugin/bad-whitespaces.vim"
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

ca ebw EraseBadWhitespace
