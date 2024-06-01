# My dotfiles

This directory contains the dotfiles for my systems which are macOS or Arch(by the way)

## Requirements

Ensure you have the following installed on your system

### Run Manually On Fresh OS Install for any Unix System
```shell
# Setup ssh key
ssh-keygen -t ed25519 -C "$USER macbook @ $EPOCHSECONDS" -f ~/.ssh/ -q -N ""

# Create directories
mkdir -p ~/projects ~/programs
```

### Git and Stow
#### Arch
```
pacman -S git stow
```

#### macOS
```shell
# Install brew and all my brew formulae and casks
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update && brew upgrade

brew install git stow
```

### Clone this repo y La Playa
```shell
# Clone my dotfiles and python playa
git clone git@github.com:stevencarpenter/python_playa.git ~/projects/
git clone git@github.com:stevencarpenter/.dotfiles.git ~/
```


## Stow plan command. Remove n for live run.
```
stow -nvvv ~/.dotfiles/home
```
