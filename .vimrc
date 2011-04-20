set nocompatible
set backspace=indent,eol,start
set history=500
set encoding=utf-8
set showcmd
set nu

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

au BufEnter *.c,*.h,*.py,*.xml,*.php call HighlightUnwantedSpaces()
