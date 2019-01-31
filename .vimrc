" common settings
" hi := highlight
" colo := colorscheme
"
" judge platform
function! Mysystem()
  if has("win32")
    return "windows"
  else
    return "linux"
  endif
endfunction

set tags+=./tags;/;/usr/include/c++/6.3.1/stdcpp.tags
set nocompatible
set exrc
set secure
set diffopt=iwhite

if &diff
  colo murphy
else
  colo pablo
endif
" hi Search guibg=peru guifg=wheat

" set how many lines of history VIM has to remember
set history=40

" set to auto read when a file is changed outside
set autoread

" with a map leader, it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader=";"
let g:mapleader=";"
" let maplocalleader="\\"

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

set nowrap

set number
" always show current position
set ruler

set linebreak

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
set cino=>2+2(0,W4g1h1N-2

" highlight the searched items
set hlsearch

" makes search act like search in modern browsers
set incsearch

set showmatch
set matchtime=2
set wildmenu

" set wrap
" set cursorline
set formatoptions=tcrqn 
set noerrorbells 
set linespace=0 

syntax enable
syntax on

" configure backspace so it acts as it should act
set backspace=indent,eol,start
mapclear

if Mysystem() == "windows"
  map <leader>e :e! ~\.vimrc<cr>
  map <leader>u :source ~\.vimrc<cr>
else
  map <leader>e :e! ~/.vimrc<cr>
  map <leader>u :source ~\.vimrc<cr>
  autocmd! bufwritepost vimrc source ~/.vimrc
  set gfn=Monospace\ 10
endif

" use space key to turn on/off the fold.
set foldenable 

" add a bit extra margin to the left
set foldcolumn=0
set foldlevel=4

set foldmethod=syntax
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR> 

let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1

" gui setting.
set guioptions-=T
set guioptions-=m
set guifont=Monospace\ Regular\ 10
" set guifont=Consolas

" no annoying sound on errors
set noerrorbells
set novisualbell
set tm=500

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
  autocmd FileType xml,html,c,cc,cs,java,perl,shell,bash,cpp,python,vim,php,ruby set number 
  autocmd FileType c,cc,cpp,java,bash,python
        \ if exists('+colorcolumn') |
        \   set colorcolumn=81 |
        \ else |
        \   au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1) |
        \ endif
  autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>o--> 
  autocmd FileType txt set wrap
  autocmd FileType xml,html set colorcolumn=180
  autocmd FileType python set colorcolumn=81
  autocmd FileType tex set colorcolumn=161
  autocmd FileType java,c,cpp,cs vmap <C-o> <ESC>'<o 
  autocmd FileType html,text,php,c,java,xml,bash,shell,perl setlocal textwidth=100 
  autocmd Filetype xsl source $VIMRUNTIME/plugin/closetag.vim 
  autocmd BufReadPost * 
        \ if line("'\"") > 0 && line("'\"") <= line("$") | 
        \ exe " normal g`\"" | 
        \ endif 
  autocmd BufWrite *.py,*.c,*.cpp,*.h,*.cc,*.mk,makefile,*.js,*.tex :call DeleteTrailingWS()
  autocmd BufWrite *.coffee :call DeleteTrailingWS()
endif "has("autocmd") 

if has('cscope')
  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help
endif

map <A-g> :cs find g <cword><cr>

" execute pathogen#infect()
" vundle env settings
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
" vundle plugins are all listed between vundle#begin() and vundle#end()
call vundle#begin()
" Plugin 'scrooloose/nerdtree'
Plugin 'c.vim'
Plugin 'VundleVim/Vundle.vim'
" Plugin 'Lokaltog/vim-powerline'
Plugin 'scrooloose/syntastic'
" Plugin 'lervag/vimtex'
" Plugin 'majutsushi/tagbar'
Plugin 'Valloric/YouCompleteMe'
" Plugin 'rdnetto/YCM-Generator', {'branch': 'stable'}
" Plugin 'honza/vim-snippets'
" Plugin 'SirVer/ultisnips'
" Plugin 'tpope/vim-pathogen'
" Plugin 'tpope/vim-sensible'
" Plugin 'tpope/vim-scriptease'
" Plugin 'octol/vim-cpp-enhanced-highlight'
" Plugin 'flazz/vim-colorschemes'
"Plugin 'altercation/vim-colors-solarized'
" Plugin 'felixhummel/setcolors.vim'
" Plugin 'tpope/vim-fugitive'
" Plugin 'bling/vim-airline'
call vundle#end()
filetype plugin indent on

set statusline+=%F
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_c_remove_include_errors = 0
let g:syntastic_cpp_checkers = ['cpplint']
let g:syntastic_cpp_cpplint_thres = 2
let g:syntastic_cpp_cpplint_args = 1
let g:syntastic_python_checkers = ['pylint']
let g:ycm_confirm_extra_conf = 0
" let g:vimtex_compiler_latexmk = {'callback' : 0}
" " 
let tagbar_left=1
nnoremap <leader>lt :TagbarToggle<CR>
let tagbar_width=32
let g:tagbar_compact=1
let g:tagbar_type_cpp = {
    \ 'kinds' : [
         \ 'c:classes:0:1',
         \ 'd:macros:0:1',
         \ 'e:enumerators:0:0', 
         \ 'f:functions:0:1',
         \ 'g:enumeration:0:1',
         \ 'l:local:0:1',
         \ 'm:members:0:1',
         \ 'n:namespaces:0:1',
         \ 'p:functions_prototypes:0:1',
         \ 's:structs:0:1',
         \ 't:typedefs:0:1',
         \ 'u:unions:0:1',
         \ 'v:global:0:1',
         \ 'x:external:0:1'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }

nmap <leader>y "+y
nmap <leader>w :w!<cr>
nmap <leader>x :x<cr>
nmap <leader>t :tabe %:p:h<cr>
nmap <leader>s :vs %:p:h<cr>
nmap <leader>o :sp %:p:h<cr>
nmap <leader>q :q!<cr>
nmap <leader>p <alt><tab><f5><alt><tab>
nmap <leader>k :YcmDiags<cr>
nmap <leader>c ^i// <esc>
nmap <leader>n ^3x
nmap <leader>h :vert help<cr>
nmap to :TrinityToggleAll<cr>
" opens a new tab with the current buffer's path
" map <leader>te :tabe <c-r>=expand("%")<cr>/

" switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

vnoremap // y/<C-R>"<CR>
" copy selected content to clipboard
vnoremap <leader>y "+y
" paste copied content from clipboard
vnoremap <leader>p "+p

" smart way to switch between windows
nmap <C-=> <C-W>=

set switchbuf=useopen,usetab

" let g:CCTreeCscopeDb = "cscope.out"
" let g:CCTreeRecursiveDepth = 3
" let g:CCTreeMinVisibleDepth = 3
" let g:CCTreeOrientation = "leftabove"

