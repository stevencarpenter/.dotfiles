#!/bin/bash

set -ex

# Create the zshenv file if it does not exist.
sudo touch ~/.zshenv

# Add XDG env variables and ZDOTDIR so shell can find the configs where they belong in ~/.config
sudo sh -c 'echo "
export XDG_CONFIG_HOME=\"\$HOME/.config\"
export XDG_DATA_HOME=\"\$HOME/.local/share\"
export ZDOTDIR=\"\$XDG_CONFIG_HOME/zsh\"
" >> ~/.zshenv'
