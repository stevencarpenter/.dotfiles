#!/usr/bin/env bash

set -ex

printf 'Setting up this macBook with all your shit. Make sure you already ran the commands from the README that installs git and brew.'
printf 'This script will delete existing config folders and create symlinks with the ones in this repo!\n'
printf 'It will also install a ton of stuff you need like applications, languages, and tooling.\n'

read -r -p "Are you sure you want to contine? [y/N] " response
response=${response,,}    # tolower
if [[ ! "$response" =~ ^(yes|y)$ ]]; then exit 0; fi

# XCODE
sudo xcode-select --install

# Install Brewfile contents and make sure things are chyll (with a y)
brew bundle --file=~/.dotfiles/macOS/Brewfile
brew bundle check --verbose
brew doctor

# Make executable and run the script to setup the /etc/zsh/zshenv
chmod +x ~/.dotfiles/scripts/populate_home_zenv.sh
sudo bash ~/.dotfiles/scripts/populate_home_zenv.sh

# Run stow to link dotfiles
cd ~/.dotfiles/ || exit
stow -vvv home
cd ~ || exit

#Run unix setup script
chmod +x ~/.dotfiles/scripts/setup_unix.sh
zsh ~/.dotfiles/scripts/setup_unix.sh

# pipx
pipx ensurepath

# pyenv
pyenv install -s -v 3
pyenv global 3

# poetry
pipx install poetry
poetry -V

# Install rustup
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y


