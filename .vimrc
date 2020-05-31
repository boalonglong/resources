function! Mysystem()
  if has("win32")
    return "windows"
  else
    return "linux"
  endif
endfunction

"{Mappings
  let mapleader=";"
  let g:mapleader=";"
  nmap <leader>w :w!<cr>
  if Mysystem() == "windows"
    map <leader>e :e! ~\.vimrc<cr>
    map <leader>u :source ~\.vimrc<cr>
  else
    map <leader>e :e! ~/.vimrc<cr>
    map <leader>u :source ~/.vimrc<cr>
    autocmd! bufwritepost vimrc source ~/.vimrc
  endif
  nnoremap <leader>lt :TagbarToggle<CR>
  nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR> 
  nmap <leader>y "+y
  nmap <leader>x :x<cr>
  nmap <leader>t :tabe %:p:h<cr>
  nmap <leader>s :vs %:p:h<cr>
  nmap <leader>q :q!<cr>
  " smart way to switch between windows
  nmap to :TrinityToggleAll<cr>
  vnoremap // y/<C-R>"<CR>
  " copy selected content to clipboard
  vnoremap <leader>y "+y
  " paste copied content from clipboard
  vnoremap <leader>p "+p
"}

"{vundle setup
  set nocompatible
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  " vundle plugins are all listed between vundle#begin() and vundle#end()
  call vundle#begin()
  Plugin 'bling/vim-airline'
  Plugin 'jaxbot/semantic-highlight.vim'
  Plugin 'scrooloose/nerdtree'
  Plugin 'scrooloose/syntastic'
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'majutsushi/tagbar'
  call vundle#end()
"}

"{Basic settings
  colorscheme PaperColor
  filetype on
  filetype plugin indent on
  highlight CursorLine term=reverse
  highlight CursorColumn term=reverse
  let tagbar_left=1
  let tagbar_width=32
  let &colorcolumn=join(range(81,999),",")
  let &colorcolumn="80,".join(range(120,999),",")
  let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
  if gitroot != ''
    let &tags = &tags . ',' . gitroot . '/.git/tags'
  endif
  set autochdir
  set autoindent
  set autoread  " set to auto read when a file is changed outside
  set autowrite
  set autowriteall  "Auto-write all file changes
  set completeopt=menuone,menu,preview,longest
  set cindent        " configurable to different indenting styles.
  set cino=>2+2(0,W4g1h1N-2
  set confirm                 " Confirm before vim exit
  set copyindent
  set cursorcolumn
  set cursorline
  " configure backspace so it acts as it should act
  set backspace=indent,eol,start
  set dictionary+=/usr/share/dict/words
  set dictionary+=~/.vim/dict/
  set diffopt=iwhite
  set display+=lastline
  set exrc
  set encoding=utf-8
  set fileencodings=utf-8,gbk,utf-16le,cp1252,iso-8859-15,,gb2312,cp936,usc-bom
  set fileencoding=utf-8
  set fileformats=unix,dos,mac
  set fileformat=unix  " set unix as the standard file type
  set foldmethod=syntax
  set foldlevel=4
  set foldlevelstart=99
  set foldenable  " use space key to turn on/off the fold.
  set formatoptions+=t
  if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j " Delete comment chars when join comment lines
  endif
  set formatoptions-=l " wrap long lines
  set guioptions=e "only show guitablabel
  set guifont=Monospace\ Regular\ 10
  set hidden
  set history=1000  " set how many lines of history VIM has to remember
  set hlsearch  " highlight the searched items
  set incsearch  " makes search act like search in modern browsers
  set ignorecase
  set iskeyword-=_,.,=,-,:,
  set laststatus=2  " always show statusline
  set lazyredraw  " don't update the display while executing macros
  set linespace=0 
  set nobackup  " turn backup off, since most stuff is in SVN, git et.c anyway
  set noerrorbells
  set nomodeline                  " disable mode lines (security measure)
  set nospell
  set noswapfile
  set nowrap
  set nowritebackup
  set number
  set ruler " always show current position
  if !&scrolloff
    set scrolloff=1  " Minimum lines to keep above and below cursor
  endif
  if !&sidescrolloff
    set scrolloff=5
  endif
  set shortmess+=filmnrxoOtT  " Abbrev. of messages (avoids 'hit enter')
  set showcmd  " Show partial commands in status line and
  set showmatch
  set showmode  " Display current mode
  set showtabline=2
  set smartcase
  set smartindent    
  set smarttab
  set switchbuf=useopen  " reveal already opened files from the quickfix
                         " window instead of opening new buffers, options: usetab
  set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  set tags+=./.tags;/;/usr/include/c++/6.3.1/stdcpp.tags
  set textwidth=80
  set timeoutlen=500
  set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
  set virtualedit=onemore  " used with caution of breaking plugins
  set novisualbell
  set whichwrap=b,s,h,l,<,>,>h,[,]   " Backspace and cursor keys wrap too
  set wildignore=*.o,*~,*.pyc,*.swp,*.bak,*.class
  set wildmenu
  set wildmode=list:longest,full
  set wrapmargin=2  " 2 chars wrap margin from the right window border, hard wrap
  if has('syntax')
    syntax enable
  endif
"}

"{Plugin settings
  "{scrooloose/syntastic
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_c_remove_include_errors = 0
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 1
  let g:syntastic_cpp_checkers = ['cpplint']
  let g:syntastic_cpp_cpplint_thres = 2
  let g:syntastic_cpp_cpplint_args = 1
  let g:syntastic_enable_signs=1
  let g:syntastic_aggregate_errors=1
  let g:syntastic_error_symbol="E"
  let g:syntastic_warning_symbol="W"
  let g:syntastic_shell_checkers = ['shellcheck']
  let g:syntastic_python_checkers = ['pylint']
  highlight SyntasticError guibg=#2F0000
  "}
"}

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
  autocmd FileType txt set wrap
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

let g:ycm_confirm_extra_conf = 0
" let g:vimtex_compiler_latexmk = {'callback' : 0}
" " 
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

