set nocompatible              " required
let mapleader=","             " change the leader to be a comma vs slash
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here
" (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'tmhedberg/SimpylFold' " code folding
Plugin 'vim-scripts/indentpython.vim'
"Plugin 'davidhalter/jedi-vim' " python command completion
"Plugin 'scrooloose/syntastic' " syntax stuff
Plugin 'w0rp/ale' " syntax stuff for vim 8.
Plugin 'scrooloose/nerdtree' " file browsing
Plugin 'tpope/vim-fugitive' " git integration
Plugin 'vim-airline/vim-airline' " status bar at the bottom
Plugin 'vim-airline/vim-airline-themes'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
"Plugin 'garbas/vim-snipmate' " snippet thingy
"Plugin 'honza/vim-snippets' " all the snippets
Plugin 'ctrlpvim/ctrlp.vim' " fuzzy file finder, really slow
Plugin 'AutoComplPop' " little popup window that I really like
"Plugin 'python/black' " code formatter
"Plugin 'changyuheng/color-scheme-holokai-for-vim' " colorscheme
Plugin 'holokai' " colorscheme

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" ==========================================================
" Basic Settings
" ==========================================================
syntax on                   " syntax highlighing
filetype on                 " try to detect filetypes
set number                  " Display line numbers
set numberwidth=1           " using only 1 column (and 1 space) while possible
set background=dark         " We are using dark background in vim
set title                   " show title in console title bar
set wildmenu                " Menu completion in command mode on <Tab>
set wildmode=full           " <Tab> cycles between all matching choices.
set noswapfile

" don't bell or blink
set noerrorbells
set vb t_vb=

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

set grepprg=ack             " replace the default grep program with ack

" Disable the colorcolumn when switching modes.  Make sure this is the
" first autocmd for the filetype here
"autocmd FileType * setlocal colorcolumn=0

""" Insert completion
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window

""" Moving Around/Editing
set cursorline              " have a line indicate the cursor location
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
"set nowrap                  " don't wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
set tabstop=4               " <tab> inserts 4 spaces
set shiftwidth=4            " but an indent level is 2 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
set foldmethod=indent       " allow us to fold on indents
set foldlevel=99            " don't fold by default
set pastetoggle=<F2>

" Fix the indentation of comments in python
filetype plugin indent on

" don't outdent hashes
" inoremap # #

" close preview window automatically when we move around
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"""" Reading/Writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

"""" Messages, Info, Status
set ls=2                    " allways show status line
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
" set ruler                   " Show some info, even without statuslines.
" set laststatus=2            " Always show statusline, even if only 1 window.
" set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>
"set list

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

"""" Display
if has("gui_running")
    " Remove menu bar
    set guioptions-=m

    " Remove toolbar
    set guioptions-=T
endif

if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
      set t_Co=256
  endif

"colorscheme elflord
"colorscheme distinguished
"colorscheme grb256
colorscheme holokai

" ==========================================================
" Short Cuts
" ==========================================================
" Paste from clipboard
map <leader>p "+p

" Quit window on <leader>q
nnoremap <leader>q :q<CR>

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Select the item in the list with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Turn on/off line numbers on <leader> ln/nl
nnoremap <leader>nl :set nonumber<CR>
nnoremap <leader>ln :set number<CR>

" Open/Close NerdTree
nnoremap <leader>nt :NERDTreeToggle<CR>

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"split navigations
nnoremap <C-J> <C-W><C-J> " down
nnoremap <C-K> <C-W><C-K> " up
nnoremap <C-L> <C-W><C-L> " right
nnoremap <C-H> <C-W><C-H> " left

" Enable code folding with the spacebar
nnoremap <space> za

" Reload Vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" autocompletion short cut
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" syntastic hide signs
nnoremap <leader>s :SyntasticReset<CR>

" ==========================================================
" Customizations
" ==========================================================

" syntastic
"let g:syntastic_error_symbol = '✗✗'
"let g:syntastic_warning_symbol = '!!'
"let g:syntastic_style_error_symbol = 'S✗'
"let g:syntastic_style_warning_symbol = 'S!'

"let g:syntastic_python_checkers = ['flake8' ]
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_python_flake8_args = '--ignore="E501,E302,E261,E701,E241,E126,E127,E128,W801,W391,E265,E266"'
"let g:syntastic_quiet_messages = { "type": "style" }

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"hi SyntasticErrorSign ctermfg=red ctermbg=NONE
"hi SyntasticWarningSign ctermfg=lightyellow ctermbg=NONE
"hi SyntasticStyleErrorSign ctermfg=lightgreen ctermbg=NONE
"hi SyntasticStyleWarningSign ctermfg=lightblue ctermbg=NONE

""" Ale Syntax
let g:ale_sign_error = '✗✗'
let g:ale_sign_warning = '!!'
let g:ale_style_error = 'S✗'
let g:ale_style_warning = 'S!'
hi ALEErrorSign ctermfg=red ctermbg=NONE
hi ALEWarningSign ctermfg=lightyellow ctermbg=NONE
hi ALEStyleError ctermfg=lightgreen ctermbg=NONE
hi ALEStyleWarning ctermfg=lightblue ctermbg=NONE
let g:ale_python_flake8_options = '--ignore="E501,E302,E261,E701,E241,E126,E127,E128,W801,W391,E265,E266"'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:airline#extensions#ale#enabled = 1


""" Insert completion
" don't select first item, follow typing in autocomplete
 set completeopt=menuone,longest,preview
 set pumheight=6             " Keep a small completion window

" jedi
let g:jedi#use_splits_not_buffers = "left"

" NerdTree
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '\.gem$',  '\.rbc$', '\~$']
let NERDTreeShowBookmarks=1       " Show the bookmarks table on startup
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" Airline
"set laststatus=2

"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#enabled = 1

let g:airline_powerline_fonts = 1

let g:Airline = {
      \ 'theme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" ==========================================================
" Python
" ==========================================================

let python_highlight_all=1

" Python Indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

if exists("&colorcolumn")
    set colorcolumn=79
endif

" show docstring previews on folded code
let g:SimpylFold_docstring_preview=1

" Flag Unnecessary Whitespace
highlight BadWhitespace ctermbg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
