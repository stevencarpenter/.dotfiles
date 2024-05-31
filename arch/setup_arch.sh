#!/bin/bash

# Make executable and run the script to setup the /etc/zsh/zshenv
chmod +x ~/.dotfiles/scripts/populate_sys_zenv.sh
bash .dotfiles/scripts/populate_sys_zenv.sh

#Set caps lock to escape and make hitting both shifts turn on caps lock
setxkbmap -option caps:escape,shift:both_capslock &

# Install everything I need from pacman and their dependencies
sudo pacman -Syu ripgrep neovim tmux less strace
