
set nocompatible   " 关闭 vi 兼容模式

syntax on          " 自动语法高亮

if v:version >= 600
  filetype plugin on
else
  filetype on
endif


set number         " 显示行号
"set cursorline     " 突出显示当前行
set ruler          " 打开状态栏标尺

"set autoindent
set noautoindent
"set cindent
set nocindent
"set smartindent
set nosmartindent
"TAB替换为空格： 
"set ts=4
"set expandtab      "set noexpandtab
"%retab!

set confirm        " Popup confirm for readonly or unstored file when close file

set shiftwidth=4   " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4  " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4      " 设定 tab 长度为 4
set backspace=2    " 可随时用退格键删除

"set paste          " Set Paste Mode which let all paste content not auto indent

set nobackup       " 覆盖文件时不备份
set noswapfile     " 禁止生成临时文件

set autochdir      " 自动切换当前目录为当前文件所在的目录

set incsearch      " 输入搜索内容时就显示搜索结果
set hlsearch       " 搜索时高亮显示被找到的文本
set noerrorbells   " 关闭错误信息响铃
set novisualbell   " 关闭使用可视响铃代替呼叫

set equalalways    " 同时显示两个相等大小的窗口

set noexpandtab    " 不要用空格代替制表符

set foldenable          " 开始折叠
"set foldmethod=syntax   " 设置语法折叠
set foldmethod=manual
set foldcolumn=0        " 设置折叠区域的宽度
setlocal foldlevel=1    " 设置折叠层数为1

nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR> " 用空格键来开关折叠

set history=1000   " history文件中需要记录的行数

set clipboard+=unnamed  " 与windows共享剪贴板

set nosplitbelow   " 窗口的分割会把新窗口放到当前窗口之下


"允许使用鼠标点击定位
"set mouse=a

"允许区域选择
"set selection=exclusive
"set selectmode=mouse,key


"语言环境
"set encoding=utf-8
"langua message zh_CN.UTF-8
"set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,gb2312,gbk    "设置字符编码列表
"set guifontwide=新宋体:h14 "设置中文的字体
"set guifont=Bitstream_Vera_Sans_Mono:h14:cANSI:b  "设置英文的字体 :b加粗 :i斜体


" 状态栏
set laststatus=2      " 总是显示状态栏
highlight StatusLine cterm=bold ctermfg=black ctermbg=white
" 获取当前路径，将$HOME转化为~
function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction

set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\


