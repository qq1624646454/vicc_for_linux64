"
"
"
if v:version >= 700
    if filereadable(expand("~/.vim/java_tags/tags"))
        autocmd FileType java set tags+=~/.vim/java_tags/tags
    endif
endif

