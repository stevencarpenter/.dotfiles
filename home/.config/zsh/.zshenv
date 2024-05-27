#!/usr/bin/env zsh

# ----------------------------------------------------------------------
# Zsh Environment Configuration:
# ----------------------------------------------------------------------
# Executed every time Zsh starts to initialize environment variables and
# basic settings.
# No need to export anything here, as .zshenv is sourced for 
# _every_ shell (unless invoked with `zsh -f`).
# ----------------------------------------------------------------------

# Set XDG_CONFIG_HOME and XDG_STATE_HOME if they are not already set
: "${XDG_CONFIG_HOME:=${HOME}/.config}"
: "${XDG_STATE_HOME:=${HOME}/.local/state}"

# Set ZDOTDIR to store other Zsh dotfiles
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# Disable save/restore mechanism from /private/etc/zshrc_Apple_Terminal
SHELL_SESSIONS_DISABLE=1

. "$HOME/.cargo/env"

