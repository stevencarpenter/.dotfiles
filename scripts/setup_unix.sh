#!/usr/bin/env zsh

set -euo pipefail

# Install atuin
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

# Install UV
curl -fsSL https://uv.sh/install.sh | sh

# Setup tmux TPM
mkdir -p "$XDG_CONFIG_HOME"/tmux/plugins
if [[ -d "$XDG_CONFIG_HOME"/tmux/tpm && ! -d "$XDG_CONFIG_HOME"/tmux/plugins/tpm ]]; then
  mv "$XDG_CONFIG_HOME"/tmux/tpm "$XDG_CONFIG_HOME"/tmux/plugins/tpm
fi
if [[ -d "$XDG_CONFIG_HOME"/tmux/tpm ]]; then
  rm -rf "$XDG_CONFIG_HOME"/tmux/tpm
fi
if [[ ! -d "$XDG_CONFIG_HOME"/tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME"/tmux/plugins/tpm
fi
