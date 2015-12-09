" judge platform
function! Mysystem()
  if has("win32")
    return "windows"
  else
    return "linux"
  endif
endfunction

colorscheme desert
set nocompatible
set autoread
set encoding=utf8
set fileencodings=utf-8,gbk,gb2312,cp936,usc-bom,euc-jp,gb18030
set fileformat=unix
set fileformats=unix,dos,mac
set nobackup

set number
set ruler
set linebreak
set textwidth=80
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set showtabline=2
set smarttab
set hlsearch       " highlight the searched items
set showmatch
set matchtime=2

set autoindent
set smartindent
set cindent
set wrap

filetype on
filetype plugin on
filetype indent on

let mapleader=","
let g:mapleader=","
let maplocalleader="\\"

nmap <leader>w :w!<cr>

if Mysystem() == "windows"
  map <leader>e :e! $VIM\_vimrc<cr>
  set gfn=Menlo:h14
else
  map <leader>e :e! ~/.vimrc<cr>
  autocmd! bufwritepost vimrc source ~/.vimrc
  set gfn=Monospace\ 10
endif

syntax on
