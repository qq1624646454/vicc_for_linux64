
" OmniCppComplete
if v:version >= 700
  let OmniCpp_GlobalScopeSearch   = 1
  let OmniCpp_DisplayMode         = 1
  let OmniCpp_ShowScopeInAbbr     = 0 "do not show namespace in pop-up
  let OmniCpp_ShowPrototypeInAbbr = 1 "show prototype in pop-up
  let OmniCpp_ShowAccess          = 1 "show access in pop-up
  let OmniCpp_SelectFirstItem     = 1 "select first item in pop-up

  let OmniCpp_NamespaceSearch = 1
  let OmniCpp_MayCompleteDot = 1 " autocomplete after .
  let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
  let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
  let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

  " automatically open and close the popup menu / preview window
  " au InsertLeave * if pumvisible() == 0|silent! pclose|endif

  " automatically close preview window when press ) symbol
  " It is implemented by ClosePair(...) 

  set completeopt=menuone,menu,longest,preview

endif

""if v:version >= 700
""  highlight   clear
""  highlight   Pmenu         ctermfg=0 ctermbg=2
""  highlight   PmenuSel      ctermfg=0 ctermbg=7
""  highlight   PmenuSbar     ctermfg=7 ctermbg=0
""  highlight   PmenuThumb    ctermfg=0 ctermbg=7
""endif




