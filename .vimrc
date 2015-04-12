set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/genutils'
Plug 'xolox/vim-misc'

Plug 'kien/ctrlp.vim'
Plug 'camelcasemotion'
Plug 'digitaltoad/vim-jade', { 'for': 'jade' }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': 'mkd' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'mattn/emmet-vim', { 'for': ['html', 'xml'] }
Plug 'lervag/vim-latex'
Plug 'christoomey/vim-tmux-navigator'
Plug 'bling/vim-airline'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/syntastic'
Plug 'altercation/vim-colors-solarized'
Plug 'editorconfig/editorconfig-vim'
Plug 'marijnh/tern_for_vim', { 'for': 'javascript' }
Plug 'tpope/vim-surround'
Plug 'rhysd/committia.vim'
Plug 'gcmt/wildfire.vim'
Plug 'svermeulen/vim-repeat'
Plug 'svermeulen/vim-easyclip'
Plug 'jonathanfilip/vim-lucius'
Plug 'Lokaltog/vim-easymotion'
Plug 'matchit.zip'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --omnisharp-completer' }
Plug 'kana/vim-submode'
Plug 'sjl/gundo.vim'
Plug 'chreekat/vim-paren-crosshairs'
Plug 'danro/rename.vim'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'tpope/vim-commentary'

call plug#end()

" Colorscheme
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

set background=dark
let g:lucius_use_underline = 0
colorscheme lucius
LuciusBlack

syntax on

set number
set shiftwidth=4
set tabstop=4
set colorcolumn=80
set textwidth=0

set autoindent
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase

set nowrap
set linebreak
set nolist

set expandtab
set smarttab

"keep backup files in central directory (dirs have to exist)
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

"enable persistent undo (directory has to exist)
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000

" No error bells
set noeb vb t_vb=

"better tab-completion
set wildmode=longest,list,full
set wildmenu
set hidden

set scrolloff=5

"Always display status bar (vim-airline)
set laststatus=2

"Always use the system register
set clipboard=unnamed,unnamedplus

" Allow backspace to delete previously entered characters
set backspace=indent,eol,start

if has("gui_running")
   " Remove Toolbar
   set guioptions-=T
endif

let mapleader = " "
let maplocalleader = "\\"

set pastetoggle=<F2>

" buffer related stuff
nnoremap tn  :enew<CR>
nnoremap tj  :bp<CR>
nnoremap tk  :bn<CR>
nnoremap tq  :bw<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

"Movement in wrapped lines
nmap j gj
nmap k gk
nmap 0 g0
nmap $ g$

nmap <C-s> :w<CR>

nmap w ,w
nmap b ,b
nmap e ,e
nmap ss :w<CR>

nmap <leader><CR> :nohlsearch<CR>
nmap <leader>s :w<CR>

" window-stuff with leader w
nmap <leader>ws :split<CR>
nmap <leader>w<S-s> :vsplit<CR>
nmap <leader>wq <C-w>q

call submode#enter_with('vresize', 'n', '', '<leader>wj', ':resize -1<CR>')
call submode#enter_with('vresize', 'n', '', '<leader>wk', ':resize +1<CR>')
call submode#leave_with('vresize', 'n', '', '<Esc>')
call submode#map('vresize', 'n', '', 'j', ':resize -1<CR>' )
call submode#map('vresize', 'n', '', 'k', ':resize +1<CR>')

call submode#enter_with('resize', 'n', '', '<leader>wh', ':vertical resize -1<CR>')
call submode#enter_with('resize', 'n', '', '<leader>wl', ':vertical resize +1<CR>')
call submode#leave_with('resize', 'n', '', '<Esc>')
call submode#map('resize', 'n', '', 'h', ':vertical resize -1<CR>' )
call submode#map('resize', 'n', '', 'l', ':vertical resize +1<CR>')

" Source-code manipulation with leader s
" alignment stuff with leader a
nmap <Leader>sa= :Tabularize /=\zs<CR>
nmap <Leader>sa: :Tabularize /:\zs<CR>
vmap <Leader>sa\| :Tabularize /\|<CR>

nmap <Leader>su :call UnWrap()<CR>
nmap <Leader>scc gcc
vmap <Leader>sc gc

"press gp to reselect pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" map M to work just like D used to work without easyclip
nmap <S-m> v$hm

nmap <S-u> :GundoToggle<CR>

"Enable emmet only for html-ish files
let g:user_emmet_install_global = 0
autocmd FileType html,css,xml EmmetInstall
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.jade set filetype=jade

au BufNewFile,BufRead *.less set filetype=less

" Unwraps a block of code
function! UnWrap()
    let cursor = getpos( "." )
    :normal $<%
    :normal $%dd
    call setpos( ".", cursor )
    :normal dd
endfunction

" Enable relative numbers for currently focused window
set number
if has('autocmd')
augroup vimrc_linenumbering
    autocmd!
    autocmd WinLeave *
                \ if &number |
                \   set norelativenumber |
                \ endif
    autocmd BufWinEnter *
                \ if &number |
                \   set relativenumber |
                \ endif
    autocmd VimEnter *
                \ if &number |
                \   set relativenumber |
                \ endif
augroup END
endif

let g:ctrlp_custom_ignore = '\v[\/](.git|
                                   \.hg|
                                   \.svn|
                                   \node_modules|
                                   \bower_components|
                                   \.session.vim)$'

let g:ycm_autoclose_preview_window_after_completion = 1

"check for correct indentation only
let g:airline#extensions#whitespace#checks = [ 'indent' ]

" allow spaces after tabs
let g:airline#extensions#whitespace#mixed_indent_algo = 1

"display buffers
let g:airline#extensions#tabline#enabled = 1

"use powerline fonts
let g:airline_powerline_fonts = 1

" html checker doesn't know html5...
let g:syntastic_html_checkers = []

let g:syntastic_javascript_checkers = ['jshint']

"disable folding for vim-markdown (to prevent everything being folded on open)
let g:vim_markdown_folding_disabled=1

"don't conceal quotes in json files
let g:vim_json_syntax_conceal=0

let g:EditorConfig_verbose = 1

" share easyclip yanks between sessions
let g:EasyClipShareYanks = 1


" If ~/.vimrc.local exists, source it to support host-local configs
if filereadable( $HOME.'/.vimrc.local' )
    source ~/.vimrc.local
endif

" If .vimrc.local exists in current directory, to support project-local configs
if filereadable( ".vimrc.local" )
    source .vimrc.local
endif
