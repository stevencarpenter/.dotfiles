# My dotfiles

This directory contains the dotfiles for my systems which are macOS or Arch(by the way)

## Requirements

Ensure you have the following installed on your system

### Run Manually On Fresh OS Install for any Unix System
```shell
# Setup ssh key
ssh-keygen -t ed25519 -C "$USER macbook @ $EPOCHSECONDS"

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
# Clone my dotfiles
git clone git@github.com:stevencarpenter/.dotfiles.git ~/
```

On a work machine, you can clone this repo to your home directory, but make sure to run the following so we are using the correct private key for my Github.
```shell
git config --local core.sshCommand   'ssh -i ~/.ssh/id_ed25519_personal -o IdentitiesOnly=yes
```

## Stow plan command. Remove n for live run.
```
cd ~/.dotfiles
stow -nvvv home
```

## Setting up git filtering for secrets
This is the best resource I found that I can understand https://willcarh.art/blog/a-case-for-git-filters
