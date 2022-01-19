" specify a directory for storing plugins
call plug#begin(stdpath('data') . '/plugged')

" list plugins
Plug 'lifepillar/vim-solarized8'
Plug 'dag/vim-fish'
Plug 'ethanholz/nvim-lastplace'
Plug 'neovim/nvim-lspconfig'
Plug 'neovim/lspsaga.nvim'

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

" always scroll with cursor
set so=0 " 999

" auto apply chezmoi edits: https://www.chezmoi.io/docs/how-to/#use-your-preferred-editor-with-chezmoi-edit-and-chezmoi-edit-config
autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path "%"

" enable lsp server for typescript 
" https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
lua << EOF
require'lspconfig'.tsserver.setup{}
EOF

"setup lspsaga
