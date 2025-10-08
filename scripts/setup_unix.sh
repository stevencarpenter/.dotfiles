#!/usr/bin/env zsh

set -euo pipefail

# Install atuin
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | s

# Install UV
curl -fsSL https://uv.sh/install.sh | sh

# Setup tmux TPM
git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME"/tmux/plugins/tpm
