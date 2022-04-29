# jeffrey's fish config

# add homebrew to path (only if we are on linux)
switch (uname)
    case Linux
      eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# begin starship
starship init fish | source

# alias vim to neovim
alias vim 'nvim'
alias vimdiff 'nvim -d'

# get the ip address on macos
alias ip 'ipconfig getifaddr en0'

# shortcuts for editing dot files
alias ev 'chezmoi edit ~/.config/nvim/init.vim'
alias ef 'chezmoi edit ~/.config/fish/config.fish'
alias fishcfg 'source ~/.config/fish/config.fish'

# shortcuts for aesthetic.computer (macOS only)
alias webp 'fish ~/IdeaProjects/aesthetic.computer/system/public/disks/digitpain/webp.fish'

alias vs 'vim (sk)'
alias js 'vim (find . -name "*.js" | sk -m -n !node_modules)'
alias ff "vim (sk -c 'git ls-tree -r --name-only HEAD || ag -l -g \"\"')"

# shortcuts for projects
alias ac 'cd ~/Desktop/aesthetic.computer'

# set default editor to nvim
set -gx EDITOR nvim

# include user binaries in the shell path
fish_add_path ~/.local/bin

# empty greeting
function fish_greeting
end

# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursor to an underscore
set fish_cursor_replace_one underscore

set fish_vi_force_cursor true

# vim bindings
fish_vi_key_bindings

# https://github.com/lotabout/skim/issues/3#issuecomment-272785980
set SKIM_DEFAULT_COMMAND 'git ls-tree -r --name-only HEAD || rg --files'
