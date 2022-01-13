# jeffrey's fish config

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# begin starship
starship init fish | source

# alias vim to neovim
alias vim 'nvim'
alias vimdiff 'nvim -d'

# shortcuts for editing dot files
alias ev 'chezmoi edit ~/.config/nvim/init.vim'
alias ef 'chezmoi edit ~/.config/fish/config.fish'

# set default editor to nvim
set -gx EDITOR nvim
