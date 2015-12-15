" judge platform
function! Mysystem()
  if has("win32")
    return "windows"
  else
    return "linux"
  endif
endfunction

set nocompatible

colorscheme desert

" set how many lines of history VIM has to remember
set history=500

" enable filetype plugins
filetype on
filetype plugin on
filetype indent on

" set to auto read when a file is changed outside
set autoread

" with a map leader, it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader=","
let g:mapleader=","
let maplocalleader="\\"

set encoding=utf8
set fileencodings=utf-8,gbk,gb2312,cp936,usc-bom,euc-jp,gb18030
set fileencoding=utf-8

" set unix as the standard file type
set fileformat=unix
set fileformats=unix,dos,mac

" turn backup off, since most stuff is in SVN, git et.c anyway
set nobackup
set nowb
set noswapfile

set number
" always show current position
set ruler

set linebreak
set textwidth=80

" use spaces instead of tabs
set expandtab

" be smart when using tabs
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2
set softtabstop=2
set showtabline=2

" uses the indent from the previous line.
set autoindent

" like autoindent, 
" but also recognizes some C syntax to increase/reduce the indent.
set smartindent    
set cindent        " configurable to different indenting styles.
set cinoptions=N-s

" highlight the searched items
set hlsearch

" makes search act like search in modern browsers
set incsearch

set showmatch
set matchtime=2

set wrap
set cursorline
set formatoptions=tcrqn 
set noerrorbells 
set linespace=0 

nmap <leader>w :w!<cr>

" configure backspace so it acts as it should act
set backspace=indent,eol,start

if Mysystem() == "windows"
  map <leader>e :e! $VIM\_vimrc<cr>
  set gfn=Menlo:h14
else
  map <leader>e :e! ~/.vimrc<cr>
  autocmd! bufwritepost vimrc source ~/.vimrc
  set gfn=Monospace\ 10
endif

" smart way to switch between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" opens a new tab with the current buffer's path
map <leader>te :tabe <c-r>=expand("%:p:h")<cr>/

" switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" use space key to turn on/off the fold.
set foldenable 

" add a bit extra margin to the left
set foldcolumn=1

set foldmethod=manual 
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR> 

let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1

" gui setting.
set guioptions-=T
set guioptions-=m
set guifont=Consolas

syntax on

" no annoying sound on errors
set noerrorbells
set novisualbell
set tm=500

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" always show the status line
set laststatus=2

" format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

if has("autocmd") 
    autocmd FileType xml,html,c,cs,java,perl,shell,bash,cpp,python,vim,php,ruby set number 
    autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>o--> 
    autocmd FileType java,c,cpp,cs vmap <C-o> <ESC>'<o 
    autocmd FileType html,text,php,vim,c,java,xml,bash,shell,perl,python setlocal textwidth=100 
    autocmd Filetype html,xml,xsl source $VIMRUNTIME/plugin/closetag.vim 
    autocmd BufReadPost * 
                \ if line("'\"") > 0 && line("'\"") <= line("$") | 
                \ exe " normal g`\"" | 
                \ endif 
    autocmd BufWrite *.py,*.c,*.cpp :call DeleteTrailingWS()
    autocmd BufWrite *.coffee :call DeleteTrailingWS()
endif "has("autocmd") 

if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

