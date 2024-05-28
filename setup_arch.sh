#!/usr/bin/env zsh

# Add XDG env variables and ZDOTDIR so shell can find the configs where they belong in ~/.config
sudo echo 'if [[ -z "$XDG_CONFIG_HOME" ]]
      then
              export XDG_CONFIG_HOME="$HOME/.config"
      fi

      if [[ -d "$XDG_CONFIG_HOME/zsh" ]]
      then
              export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
      fi

      # Set the data folder
      if [[ -z "$XDG_DATA_HOME" ]]
      then
              export XDG_DATA_HOME="$HOME/.local/share"
      fi' | sudo tee -a /etc/zsh/zshenv

#Set caps lock to escape and make hitting both shifts turn on caps lock
setxkbmap -option caps:escape,shift:both_capslock &

# Install everything I need from pacman and their dependencies
sudo pacman -Syu ripgrep neovim tmux
