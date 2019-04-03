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

" visual only wordwrap
set linebreak
set listchars=tab:\ \ ,eol:¬
hi NonText ctermfg=247
set list
set textwidth=0
set wrapmargin=0
set formatoptions-=t

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

map <F4> g<C-g>

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0
let g:syntastic_enable_r_lintr_checker=1

let g:syntastic_sh_checkers= ['checkbashisms']
let g:syntastic_r_checkers= ['lintr']

" ignore some linter warnings
let g:syntastic_quiet_messages = {
    \ "regex": ['echo -e', 'alternative test command.*', 'Commented code should be removed.*', 'lines should not be more than 80 characters.*', 'Trailing blank lines are superfluous.', 'Variable and function names should be all lowercase.', 'does not appear to have a #! interpreter line;', 'Variable and function names should not be longer than 30 characters.', 'bash arrays', "'((\' should be '$(('", "should be 'b = a'", "declare", ".*foo:3.*", ".*here string", ".*pat.*"] }

hi StatusLine cterm=NONE ctermbg=NONE ctermfg=7

hi TabLineFill cterm=NONE ctermbg=NONE ctermfg=NONE
hi TabLine cterm=NONE ctermbg=NONE ctermfg=7
hi TabLineSel ctermbg=NONE ctermfg=12

"highlight commas in CSV
hi CsvComma cterm=NONE cterm=NONE ctermfg=30

" shortcut to erase bad whitepaces and tabs
ca ebw EraseBadWhitespace

" always prefer settings the original author of a file has choosen
setglobal modeline
