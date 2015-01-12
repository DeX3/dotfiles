set nocompatible              " be iMproved, required
filetype off                  " required

" Beginning of plugin section
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'vim-scripts/genutils'

Plugin 'kien/ctrlp.vim'
Plugin 'camelcasemotion'
Plugin 'digitaltoad/vim-jade'
Plugin 'groenewege/vim-less'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'elzr/vim-json'
Plugin 'mattn/emmet-vim'
Plugin 'lervag/vim-latex'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/syntastic'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'marijnh/tern_for_vim'
Plugin 'tpope/vim-surround'
Plugin 'rhysd/committia.vim'

" End of plugin section
call vundle#end()            " required by Vundle
filetype plugin indent on    " required by Vundle

" Colorscheme
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

let g:solarized_termcolors=256
colorscheme solarized
set background=dark

syntax on

set number
set sw=4
set ts=4
set tw=80
set cc=80

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

"Always display status bar (vim-airline)
set laststatus=2

if has("gui_running")
   " Remove Toolbar
   set guioptions-=T
endif

let mapleader = ";"
let maplocalleader = "\\"

set pastetoggle=<F2>

" buffer related stuff
nnoremap tk  :bn<CR>
nnoremap tj  :bp<CR>
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

"Move faster by pressing shift
nmap <S-j> 4j
nmap <S-k> 4k

"Move faster by presing shift (visual line mode)
xmap <S-j> 4j
xmap <S-k> 4k

nmap gq :bw<CR>
nmap <C-s> :w<CR>

nmap w ,w
nmap b ,b
nmap e ,e
nmap ss :w<CR>

nmap <leader><CR> :nohlsearch<CR>
nmap <leader>s :w<CR>

nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>


"Enable emmet only for html-ish files
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.jade set filetype=jade

au BufNewFile,BufRead *.less set filetype=less

let g:ctrlp_custom_ignore = '\v[\/](.git|.hg|.svn|node_modules|bower_components|doc|docs|test\/reports)$'

"press gp to reselect pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

"check for correct indentation only
let g:airline#extensions#whitespace#checks = [ 'indent' ]

" allow spaces after tabs
let g:airline#extensions#whitespace#mixed_indent_algo = 1

"display buffers
let g:airline#extensions#tabline#enabled = 1

let g:syntastic_javascript_checkers = ['jshint']
