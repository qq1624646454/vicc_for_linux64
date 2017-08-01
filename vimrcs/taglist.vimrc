
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       TAGLIST (support by ctags) - Vim Plugin Install Description 
"         http://www.vim.org/scripts/script.php?script_id=273
"
" mkdir -pv ~/.vim
" cd ~/.vim/
" 
" wget http://www.vim.org/scripts/download_script.php?src_id=19574 -O taglist_46.zip
" unzip taglist_46.zip
" rm -rvf taglist_46.zip
" tree
"
" ### Change to the ~/.vim/doc
" ### start Vim and run the ':helptags .' command to process the taglist help file. Without this step, 
" ### you cannot jump to the taglist help topics
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Ctags_Cmd = '~/.jllsystem/bin/ctags'
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 0         "在右侧窗口中显示taglist窗口
let Tlist_Display_Tag_Scope = 1
let Tlist_Enable_Fold_Column = 0       " Don't display fold tree 




