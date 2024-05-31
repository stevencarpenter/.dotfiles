#!/bin/bash

# Add XDG env variables and ZDOTDIR so shell can find the configs where they belong in ~/.config
sudo sh -c 'echo "
# Point XDG config to .config if it is not set
if [[ -z \"\$XDG_CONFIG_HOME\" ]]
then
    export XDG_CONFIG_HOME=\"\$HOME/.config\"
fi

# Point XDG data to .local/share if it is not set
if [[ -z \"\$XDG_DATA_HOME\" ]]
then
    export XDG_DATA_HOME=\"\$HOME/.local/share\"
fi

# Set the ZDOTDIR for ZSH
if [[ -d \"\$XDG_CONFIG_HOME/zsh\" ]]
then
    export ZDOTDIR=\"\$XDG_CONFIG_HOME/zsh\"
fi
" >> /etc/zsh/zshenv'
