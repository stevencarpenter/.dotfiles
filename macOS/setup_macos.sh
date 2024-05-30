#!/usr/bin/env bash

# XCODE
sudo xcode-select --install

# Add XDG env variables and ZDOTDIR so shell can find the configs where they belong in ~/.config
sudo sh -c 'echo "
if [[ -z \"\$XDG_CONFIG_HOME\" ]]
then
    export XDG_CONFIG_HOME=\"\$HOME/.config\"
fi

if [[ -d \"\$XDG_CONFIG_HOME/zsh\" ]]
then
    export ZDOTDIR=\"\$XDG_CONFIG_HOME/zsh\"
fi

# Set the data folder
if [[ -z \"\$XDG_DATA_HOME\" ]]
then
    export XDG_DATA_HOME=\"\$HOME/.local/share\"
fi
" >> /etc/zsh/zenv'

# Install Brewfile contents and make sure things are chyll (with a y)
brew bundle --file=~/.dotfiles/macOS/Brewfile
brew bundle check --verbose
brew doctor

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
