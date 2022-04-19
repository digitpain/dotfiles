if status is-interactive
    # Commands to run in interactive sessions can go here
end

# begin starship

starship init fish | source

# alias vim to neovim

alias vim 'nvim'

# shortcuts for editing files
alias ev 'nvim ~/.config/nvim/init.vim'
alias ef 'nvim ~/.config/fish/config.fish'

# shortcuts for aesthetic.computer
alias webp 'fish ~/IdeaProjects/aesthetic.computer/system/public/disks/digitpain/webp.fish'
