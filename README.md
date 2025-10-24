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

## AI Tools Configuration
Comprehensive setup and configuration for AI-powered development tools:

- **[MCP (Model Context Protocol)](docs/ai-tools/mcp-setup.md)** - Configure AI assistants with secure access to local and remote resources
- **[IntelliJ IDEA Copilot](docs/ai-tools/intellij-copilot-setup.md)** - Complete GitHub Copilot setup for IntelliJ IDEA
- **[Copilot CLI](docs/ai-tools/copilot-cli-setup.md)** - Terminal integration for GitHub Copilot
- **[OpenAI Codex CLI](docs/ai-tools/openai-codex-cli-setup.md)** - Command-line access to OpenAI's code generation
- **[Custom Terraform Instructions](docs/ai-tools/terraform-instructions.md)** - Best practices for AI-generated Terraform code

See the [AI Tools documentation](docs/ai-tools/) for detailed setup guides.
