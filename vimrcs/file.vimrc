
" Automatically Inster File Header Information when Create the new specified file
autocmd BufNewFile *.sh,*.cpp,*.[ch],*.java exec ":call SetTitle()"
func SetTitle()
    if &filetype == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."),   "\# Copyright(c) 2016-2100.  ".system("echo -n $USER").".  All rights reserved.")
        call append(line(".")+1, "\#")
        call append(line(".")+2, "\#   FileName:     ".expand("%:t"))
        call append(line(".")+3, "\#   Author:       ".system("echo -n $USER"))
        call append(line(".")+4, "\#   Email:        493164984@qq.com")
        call append(line(".")+5, "\#   DateTime:     ".strftime("%Y-%m-%d %H:%M:%S"))
        call append(line(".")+6, "\#   ModifiedTime: ".strftime("%Y-%m-%d %H:%M:%S"))
        call append(line(".")+7, "")
        call append(line(".")+8, "JLLPATH=\"\$(which \$0)\"")
        call append(line(".")+9, "JLLPATH=\"\$(dirname \${JLLPATH})\"")
        call append(line(".")+10, "\#source \${JLLPATH}/BashShellLibrary")
        call append(line(".")+11, "")
        call append(line(".")+12, "\### Color Echo Usage ###")
        call append(line(".")+13, "\# Lfn_Sys_ColorEcho \${CvFgRed} \${CvBgWhite} \"hello\"")
        call append(line(".")+14, "\# echo -e \"hello \\033[0m\\033[31m\\033[43mworld\\033[0m\"")
        call append(line(".")+15, "")
        call append(line(".")+16, "")
    else
        call setline(1,          "\/*")
        call append(line("."),   " * Copyright(c) 2016-2100.  ".system("echo -n $USER").".  All rights reserved.")
        call append(line(".")+1, " */")
        call append(line(".")+2, "\/*")
        call append(line(".")+3, " * FileName:      ".expand("%:t"))
        call append(line(".")+4, " * Author:        ".system("echo -n $USER"))
        call append(line(".")+5, " * Email:         493164984@qq.com")
        call append(line(".")+6, " * DateTime:      ".strftime("%Y-%m-%d %H:%M:%S"))
        call append(line(".")+7, " * ModifiedTime:  ".strftime("%Y-%m-%d %H:%M:%S"))
        call append(line(".")+8, " */")
        call append(line(".")+9, "")
        call append(line(".")+10, "")
    endif

    if &filetype == 'cpp'
        call append(line(".")+11, "#include <iostream>")
        call append(line(".")+12, "using namespace std;")
        call append(line(".")+13, "")
    endif
    if &filetype == 'c'
        call append(line(".")+11, "#include <stdio.h>")
        call append(line(".")+12, "#include <stdlib.h>")
        call append(line(".")+13, "#include <stdbool.h>")
        call append(line(".")+14, "#include <string.h>")
        call append(line(".")+15, "#include <sys/types.h>")
        call append(line(".")+16, "#include <sys/stat.h>")
        call append(line(".")+17, "#include <fcntl.h>")
        call append(line(".")+18, "#include <unistd.h>")
        call append(line(".")+19, "")
    endif
    if &filetype == 'java'
        call append(line(".")+11, "package src;")
        call append(line(".")+12, "")
        call append(line(".")+13, "import java.util.HashMap;")
        call append(line(".")+14, "import java.util.Map;")
        call append(line(".")+15, "import java.util.concurrent.locks.Condition;")
        call append(line(".")+16, "import java.util.concurrent.locks.Lock;")
        call append(line(".")+17, "import java.util.concurrent.locks.ReentrantLock;")
        call append(line(".")+18, "import java.io.BufferedReader;")
        call append(line(".")+19, "import java.io.File;")
        call append(line(".")+20, "import java.io.FileInputStream;")
        call append(line(".")+21, "import java.io.FileNotFoundException;")
        call append(line(".")+22, "import java.io.FileOutputStream;")
        call append(line(".")+23, "import java.io.IOException;")
        call append(line(".")+24, "import java.io.InputStreamReader;")
        call append(line(".")+25, "")
        call append(line(".")+26, "public class ".expand("%:t"))
        call append(line(".")+27, "{")
        call append(line(".")+28, "    public static void main(String[] args) throws Exception")
        call append(line(".")+29, "    {")
        call append(line(".")+30, "        System.out.println(\"Hello World\");")
        call append(line(".")+31, "    }")
        call append(line(".")+32, "}")
        call append(line(".")+33, "")
    endif
 
    " Automatically relocate the tail of the new file
    autocmd BufNewFile * normal G
endfunc


"Update Latest modified date
autocmd BufWritePost *.{h,hpp,c,cpp,java,aidl} call Update_ModifiedTime_In_Title_For_C_CPP_JAVA()
autocmd BufWritePost *.{sh} call Update_ModifiedTime_In_Title_For_SHELL()

func Update_ModifiedTime_In_Title_For_C_CPP_JAVA()
    if matchstr(getline(9), "ModifiedTime", 3) == "ModifiedTime"
        call setline(9, " * ModifiedTime:  ".strftime("%Y-%m-%d %H:%M:%S"))
    endif
endfunc
func Update_ModifiedTime_In_Title_For_SHELL()
    if matchstr(getline(8), "ModifiedTime", 4) == "ModifiedTime"
        call setline(8, "\#   ModifiedTime: ".strftime("%Y-%m-%d %H:%M:%S"))
    endif
endfunc


" Binary Edit
" vim -b : Edit the binary file by xxd format
augroup Binary
    autocmd!
    autocmd BufReadPre   *.bin,*.o,*.so,*.a,*.hex  let &bin=1
    autocmd BufReadPost  *.bin,*.o,*.so,*.a,*.hex  if &bin | %!xxd
    autocmd BufReadPost  *.bin,*.o,*.so,*.a,*.hex  set ft=xxd | endif
    autocmd BufWritePre  *.bin,*.o,*.so,*.a,*.hex  if &bin | %!xxd -r
    autocmd BufWritePre  *.bin,*.o,*.so,*.a,*.hex  endif
    autocmd BufWritePost *.bin,*.o,*.so,*.a,*.hex  if &bin | %!xxd
    autocmd BufWritePost *.bin,*.o,*.so,*.a,*.hex  set nomod | endif
augroup END


" Automatically jump to the last position when open the file.
if has("autocmd")
    :au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif


" The file is loaded automatically into vim while it is edited by other.
if exists("&autoread")
    set autoread
endif

