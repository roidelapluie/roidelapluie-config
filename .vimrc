set nocompatible
set backspace=indent,eol,start
set history=500
set encoding=utf-8
set showcmd
set nu

noremap R i<Space><Esc>r

" gajim rules
au BufEnter *.pp,*.tex,*.sh set tabstop=4 shiftwidth=4
au BufEnter *.pp,*.tex,*.sh set expandtab softtabstop=4
" gajim rules
au BufEnter *.php set tabstop=4 shiftwidth=4
au BufEnter *.php set expandtab softtabstop=4
au BufEnter *.rb,*.erb set tabstop=2 shiftwidth=2
au BufEnter *.rb,*.erb set expandtab softtabstop=2
" gajim rules
au BufEnter *.py set textwidth=80
au BufEnter *.py set tabstop=4 shiftwidth=4
au BufEnter *.py set expandtab softtabstop=4

function! HighlightUnwantedSpaces()
        " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
        highlight ExtraWhitespace ctermbg=red guibg=red
        match ExtraWhitespace /\s\+$/
        autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
        autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
        autocmd InsertLeave * match ExtraWhitespace /\s\+$/
        autocmd BufWinLeave * call clearmatches()
endfunction

au BufRead,BufNewFile *.pp              set filetype=puppet


au BufEnter *.c,*.h,*.py,*.xml,*.php,*.pp call HighlightUnwantedSpaces()
