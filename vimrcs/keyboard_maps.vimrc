
"-----------------
" Maping Keyboard
"-----------------
" automatically complete for the follows
" note: ensure set paste is igored.
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {<CR>}<ESC>O
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap ; <c-r>=ClosePair(';')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i

function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        if pumvisible() == 0|silent! pclose|endif
        return a:char
    endif
endfunction

func!  Check_FunctionName_Is_Empty()
    if !empty(getline('.')[col('.') - 2])
        if getline('.')[col('.') - 2] != ' '
            return 0
        endif
    endif
    return 1
endfunc




autocmd FileType c,cc,cpp,C,java,h  :inoremap  <TAB>  <c-r>=Map_Tab_To_CtrlX_CtrlO()<CR>

func!  Check_UnaryOperator_Is_Empty()
    if !empty(getline('.')[col('.') - 3])
        if getline('.')[col('.') - 3] != ' '
            return 0
        endif
    endif
    return 1
endfunc

func!  Check_BinaryOperator_Is_Empty()
    if !empty(getline('.')[col('.') - 4])
        if getline('.')[col('.') - 4] != ' '
            return 0
        endif
    endif
    return 1
endfunc

func! Map_Tab_To_CtrlX_CtrlO()
    "Current position is getline('.')[col('.') - 1]"
    if getline('.')[col('.') - 2] == '.'
        if Check_UnaryOperator_Is_Empty() == 0
            return "\<c-x>\<c-o>"
        endif
    endif
    if getline('.')[col('.') - 2] == '>'
        if getline('.')[col('.') - 3] == '-'
            if Check_BinaryOperator_Is_Empty() == 0
                return "\<c-x>\<c-o>"
            endif
        endif
    endif
    if getline('.')[col('.') - 2] == ':'
        if getline('.')[col('.') - 3] == ':'
            if Check_BinaryOperator_Is_Empty() == 0
                return "\<c-x>\<c-o>"
            endif
        endif
    endif
    if Check_FunctionName_Is_Empty() == 0
        return "\<c-x>\<c-o>"
    endif 
    return "\<TAB>"
endfunc

autocmd FileType c,cc,cpp,C,java,h  :nmap <F12>  :call VICC_update_ctags_cscope()<CR>
func! VICC_update_ctags_cscope()
    :!vicc -u
endfunc
