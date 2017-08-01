
let g:airline_theme="xtermlight"

let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#buffer_nr_show = 1

" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" powerline symbols
""let g:airline_left_sep = ''
""let g:airline_left_alt_sep = ''
""let g:airline_right_sep = ''
""let g:airline_right_alt_sep = ''
""let g:airline_symbols.branch = ''
""let g:airline_symbols.readonly = ''
""let g:airline_symbols.linenr = ''

" old vim-powerline symbols
""let g:airline_left_sep = '⮀'
""let g:airline_left_alt_sep = '⮁'
""let g:airline_right_sep = '⮂'
""let g:airline_right_alt_sep = '⮃'
""let g:airline_symbols.branch = '⭠'
""let g:airline_symbols.readonly = '⭤'
""let g:airline_symbols.linenr = '⭡'

"设置状态栏符号显示，下面编码用双引号"
let g:Powerline_symbols="fancy"
let g:airline_symbols = {}
let g:airline_left_sep = "\u2b80" 
let g:airline_left_alt_sep = "\u2b81"
let g:airline_right_sep = "\u2b82"
let g:airline_right_alt_sep = "\u2b83"
let g:airline_symbols.branch = "\u2b60"
let g:airline_symbols.readonly = "\u2b64"
let g:airline_symbols.linenr = "\u2b61"

set laststatus=2   " Status Line is always displayed 
set t_Co=256       " Explicitly tell Vim that the terminal supports 256 colors
set encoding=utf8

let g:airline#extensions#tabline#left_sep = "\u2b80"
let g:airline#extensions#tabline#left_alt_sep = "\u2b81"

