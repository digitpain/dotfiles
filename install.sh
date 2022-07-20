#!/bin/sh

# -e: exit on error
# -u: exit on unset variables
set -eu

create_symlinks() {
  # Get the directory in which this script lives.
  script_dir=$(dirname "$(readlink -f "$0")")

  # link fish config
  rm -rf ~/.config/fish
  ln -s $script_dir/dot_config/fish ~/.config/fish

  # link vim config
  rm -rf ~/.config/nvim
  ln -s $script_dir/dot_config/nvim ~/.config/nvim

  # link foot (a linux terminal client) config
  rm -rf ~/.config/foot
  ln -s $script_dir/dot_config/foot ~/.config/foot
}

install_fish() {
  sudo add-apt-repository ppa:fish-shell/release-3 -y
  sudo apt-get update
  sudo apt-get install fish -y
}

install_neovim() {
  sudo add-apt-repository ppa:neovim-ppa/unstable -y
  sudo apt-get update
  sudo apt-get install neovim -y
}

install_homebrew() {
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/codespace/.profile
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  sudo apt-get install build-essential
  brew install gcc
}

install_starship() {
  brew install starship
}

install_fonts() {
  mkdir -p ~/.local/share/fonts
  cd ~/.local/share/fonts && curl -fLo "Fira Code Retina Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Retina/complete/Fira%20Code%20Retina%20Nerd%20Font%20Complete.ttf
}

install_fish
install_neovim
install_homebrew
install_starship
install_fonts

create_symlinks