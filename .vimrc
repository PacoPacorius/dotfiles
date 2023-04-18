
" An example for a vimrc file.
"
" Maintainer:	PacoPacorius
" Last change:	25/11/2022
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

" freepascal shit, associate .pp files with pascal syntax, highlight math
" operators in pascal, set vim variables for freepascal
au BufRead,BufNewFile *.pp set filetype=pascal
let pascal_symbol_operator=1
let pascal_fpc=1

" use 256 colors in terminal
if !has("gui_running")
    "set t_Co=256
    "set term=xterm-256color
endif

" this is needed for tmux to display correct colors
set bg=dark

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END


" quality of life improvements
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set copyindent
set smarttab
set autoindent
set number
set nowrap
set clipboard=unnamedplus
set mouse=a

" *8*8*8*8*8*8*8*8*8*8*8
" * MAPS AND SHORTCUTS *
" *8*8*8*8*8*8*8*8*8*8*8
inoremap jj <esc>
vnoremap ii <esc>

nnoremap <M-/> I//<esc>
nnoremap <M-?> :s@//@  <CR>:nohls<CR>hhxx

" F2 to enable greek in vim
nmap <F2> :set keymap=greek_utf-8<CR>
" F2 while in insert mode to switch between greek and english
imap <F2> <C-6>

" custom directories to keep vim cleaner
set directory=/home/pacopacorius/.vim/swap//
set backup 
set backupdir=/home/pacopacorius/.vim/backup//
set undofile 
set undodir=/home/pacopacorius/.vim/undo//
if !isdirectory(expand('/home/pacopacorius/.vim/undo//')) | call mkdir(expand('/home/pacopacorius/.vim/undo//'), "p") | endif
if !isdirectory(expand('/home/pacopacorius/.vim/backup//')) | call mkdir(expand('/home/pacopacorius/.vim/backup//'), "p") | endif
if !isdirectory(expand('/home/pacopacorius/.vim/swap//')) | call mkdir(expand('/home/pacopacorius/.vim/swap//'), "p") | endif


" *6*6*6*6*6*6*6*6*6*6*
" * PLUGINS FROM PLUG *
" *6*6*6*6*6*6*6*6*6*6*

call plug#begin()
Plug 'xuhdev/vim-latex-live-preview', { 'for' : 'tex' }
call plug#end()

" Set default pdf viewer to zathura
let g:livepreview_previewer = 'zathura'
" Set Live Latex Preview engine to xelatex
let g:livepreview_engine = 'xelatex'

" ************************
" * PLUGINS WITHOUT PLUG *
" ************************

" ==============
" YouCompleteMe for autocompletion
packadd! YouCompleteMe

" Load YCM (only)
let &rtp .= ',' . expand( '<sfile>:p:h' )
filetype plugin indent on
syn on

" fallback for semantic completion
let g:ycm_global_ycm_extra_conf = '~/.vim/pack/YouCompleteMe/opt/YouCompleteMe/.ycm_extra_conf.py'

" triggers for c-style semantic completion are 3-word characters or the char '_'
let g:ycm_semantic_triggers =  {
  \   'c,cpp,objc': [ 're!\w{3}', '_' ],
  \   'html': [ 're!<', '/' ],
  \   'css' : [ 're!\w{3}', ':' ],
  \
  \ }

" autohides the autocomplete preview window when exiting from insert mode
let g:ycm_autoclose_preview_window_after_insertion=1
