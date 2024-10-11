" encoding=utf-8

" Lazy load Neovim configurations
if has('nvim')
  lua require("lazyinit")
  finish
endif

set nocompatible

set encoding=utf-8
set t_Co=256
syntax on
colorscheme slate

set mouse=a " disable mouse
set clipboard=unnamedplus " use system clipboard
let g:mapleader=" "
let g:maplocalleader="\\"

set splitbelow " default split below
set splitright " default split right

set list " show control characters
set listchars=eol:↩,trail:·,multispace:·\ ,tab:→\ ,extends:»,precedes:« " set control characters

" set signcolumn=yes " always show sign column
set number " show line number
set norelativenumber " no relative line number
set cursorcolumn " always show vertical cursor
set cursorline " always show horizontal cursor
set cursorlineopt=both " highlight text line of the cursor and the line number
set showtabline=2 " always show tabline
set laststatus=2 " always show statusline
set ruler " show ruler

set ignorecase " ignore case
set smartcase " don't ignore case with capitals
set hlsearch " highlight search

call mkdir(expand('~/.local/state/vim/backup'), 'p')
set backupdir=~/.local/state/vim/backup
set backup
call mkdir(expand('~/.local/state/vim/views'), 'p')
set viewdir=~/.local/state/vim/views
call mkdir(expand('~/.local/state/vim/swap'), 'p')
set directory=~/.local/state/vim/swap
call mkdir(expand('~/.local/state/vim/undo'), 'p')
set undodir=~/.local/state/vim/undo
set undofile
set viminfo+=n~/.local/state/vim/viminfo

set foldmethod=indent " fold by indent
set nofoldenable " disable fold by default

" set expandtab " use spaces instead of tabs
" set shiftwidth=2 " set indent width
set tabstop=4 " set tab width

" vim: ft=vim
