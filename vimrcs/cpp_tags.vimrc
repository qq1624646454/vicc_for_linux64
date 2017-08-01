"
"
"
if v:version >= 700
    if filereadable(expand("~/.vim/cpp_tags/tags"))
        autocmd FileType cpp,h,hpp,cc set tags+=~/.vim/cpp_tags/tags
    endif
endif

