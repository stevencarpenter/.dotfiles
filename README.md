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


## Stow plan command. Remove n for live run.
```
cd ~/.dotfiles
stow -nvvv home
```

## Secrets management

Secrets are no longer stored in the repository via Git filters. Runtime values
are resolved by the Keeper Secrets Manager CLI during shell startup so that the
environment stays in sync without committing sensitive data. Review
[`docs/secrets-management.md`](docs/secrets-management.md) for setup
instructions, usage tips, and guidance on integrating work secrets from
HashiCorp Vault or 1Password.

## NVIM Configuration and Plugins
This is very much a work in progress as I feel out what I like and need. I am not writing much code in vim directly, this is  more for editing configs and such. Maybe I will become a convert, who knows.

99% of the credit for this goes to https://github.com/typecraft-dev/dotfiles/tree/master/nvim/.config/nvim (thanks nerd!)
