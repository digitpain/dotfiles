" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')

Plug 'lifepillar/vim-solarized8'
Plug 'dag/vim-fish'

" Initialize plugin system
call plug#end()

" enable terminal colors to be set from app
set termguicolors

" choose my favorite colorscheme on my chosen background
set background=dark
colorscheme solarized8

" enable line numbers
set nu
