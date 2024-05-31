#!/usr/bin/env bash

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
chmod +x ~/.dotfiles/scripts/populate_sys_zenv.sh
bash .dotfiles/scripts/populate_sys_zenv.sh

cd ~/.dotfiles/home/
stow -vvv .
cd ~

# pipx
pipx ensurepath

# pyenv
pyenv install -s -v 3
pyenv global 3

# poetry
pipx install poetry
poetry -V

# Install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


