" specify a directory for storing plugins
call plug#begin(stdpath('data') . '/plugged')

" list plugins
Plug 'lifepillar/vim-solarized8'
Plug 'dag/vim-fish'
Plug 'ethanholz/nvim-lastplace'

" Initialize plugin system (🗒️ install: https://github.com/junegunn/vimplug)
call plug#end()

lua require'nvim-lastplace'.setup{}

" enable terminal colors to be set from app
set termguicolors

" choose my favorite colorscheme on my chosen background
set background=dark
colorscheme solarized8

" enable line numbers
set nu
