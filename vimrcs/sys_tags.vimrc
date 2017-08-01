"
"
"
if v:version >= 700
    if filereadable(expand("~/.vim/sys_tags/tags"))
        autocmd FileType c,cpp,h,hpp,cc,C set tags+=~/.vim/sys_tags/tags
    endif
endif

