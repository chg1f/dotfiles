" encoding=utf-8

set t_Co=256
colorscheme slate

" Lazy load Neovim configurations
if has('nvim')
  lua require("lazyinit")
endif

set nocompatible

set mouse=
let g:mapleader=" "
let g:maplocalleader="\\"

set encoding=utf-8
syntax on

set list
set listchars=eol:↩,trail:·,multispace:·\ ,tab:→\ ,extends:»,precedes:«

set signcolumn=yes " always show sign column
set number " show line number
set norelativenumber " no relative line number
set cursorcolumn " always show vertical cursor
set cursorline " always show horizontal cursor
set cursorlineopt=both " highlight text line of the cursor and the line number
set showtabline=2 " always show tabline
set laststatus=2 " always show statusline

set splitbelow " default split below
set splitright " default split right

" vim: ft=vim
