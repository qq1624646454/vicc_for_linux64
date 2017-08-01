
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      CSCOPE - Vim Plugin Install Description 
"                    http://cscope.sourceforge.net/cscope_vim_tutorial.html
"
"  apt-cache search cscope
"  apt-get install cscope
"  cd ~/.vim/plugin
"
"  wget http://cscope.sourceforge.net/cscope_maps.vim -O cscope_maps.vim
"  ---Please modify the cscope_maps.vim, shown as follows:---
"  36     " check cscope for definition of a symbol before checking ctags: set to 1
"  37     " if you want the reverse search order.
"  38     set csto=1
"
"  wget http://www.vim.org/scripts/download_script.php?src_id=14884 -O autoload_cscope.vim
"  ---Please modify the autoload_cscope.vim, shown as follows:---
"  176  au!
"  177  au BufEnter *.[chly]  call <SID>Cycle_csdb() | call <SID>Cycle_macros_menus()
"  178  au BufEnter *.cc,*.cpp,*.hpp,*.java,*.aidl     call <SID>Cycle_csdb() | call <SID>Cycle_macros_menus()
"  179  au BufUnload *.[chly] call <SID>Unload_csdb() | call <SID>Cycle_macros_menus()
"  180  au BufUnload *.cc,*.cpp,*.hpp,*.java,*.aidl    call <SID>Unload_csdb() | call <SID>Cycle_macros_menus()
"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable("cscope.out")
    cs add cscope.out
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif


