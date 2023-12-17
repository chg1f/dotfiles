" encoding=utf-8

set nocompatible
set encoding=utf-8
set mouse=

syntax on
set t_Co=256

" cursor
set cursorline
set cursorlineopt=both
set cursorcolumn

" control characters
set list
set listchars=tab:»\ ,multispace:·\ ,trail:·,extends:~,precedes:~,eol:¬

" tabline
set showtabline=2

" sign
set signcolumn=auto
set number

" ruler
set ruler

" statusline
set laststatus=2

" indent
"set autoindent
set tabstop=4
set linespace=0

" search
set hlsearch
set incsearch

" window
set splitbelow
set splitright
"set splitkeep=screen

" folder
set foldenable
set foldmethod=indent

"
set showcmd
set showmatch
set showmode

" template files
set undofile


if has('nvim')
  " executable
  if has('macunix')
    let g:clipboard= {
      \   'name': 'macOS-clipboard',
      \   'copy': {
      \     '+': 'pbcopy',
      \     '*': 'pbcopy',
      \   },
      \   'paste': {
      \     '+': 'pbpaste',
      \     '*': 'pbpaste',
      \   },
      \   'cache_enabled': 1,
      \ }
    let g:python3_host_prog='/usr/local/bin/python3'
    let g:node_host_prog='/usr/local/bin/node'
    let g:ruby_host_prog='/usr/local/bin/ruby'
    let g:perl_host_prog='/usr/local/bin/perl'
  else
    " TODO: tmux
    let g:clipboard= {
      \   'name': 'macOS-clipboard',
      \   'copy': {
      \     '+': 'xclip -selection clipboard',
      \     '*': 'xclip -selection clipboard',
      \   },
      \   'paste': {
      \     '+': 'xclip -selection clipboard -o',
      \     '*': 'xclip -selection clipboard -o',
      \   },
      \   'cache_enabled': 1,
      \ }
    let g:python3_host_prog='/usr/bin/python3'
    let g:node_host_prog='/usr/bin/node'
    let g:ruby_host_prog='/usr/bin/ruby'
    let g:perl_host_prog='/usr/bin/perl'
  endif

  let s:lazyinit=stdpath("config") .. "/lua/lazyinit.lua"
  " TODO:system("curl", "--create-dirs", "-fLo", s:lazyinit, "https://raw.githubusercontent.com/chg1f/dotfiles/main/.config/nvim/lua/lazyinit.lua")
  if filereadable(s:lazyinit)
    lua require("lazyinit")
  endif
endif

" vim:fdm=indent
