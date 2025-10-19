#!/usr/bin/env bash
set -euo pipefail

session_id="${1:-}"
if [ -z "$session_id" ]; then
  exit 0
fi

session_count=$(tmux list-sessions 2>/dev/null | wc -l | tr -d ' ')
if [ "$session_count" != "1" ]; then
  exit 0
fi

# Ensure the session only has the default window and pane before launching btop.
window_id=$(tmux list-windows -t "$session_id" -F "#{window_id}" | head -n 1)
if [ -z "$window_id" ]; then
  exit 0
fi

pane_count=$(tmux list-panes -t "$window_id" 2>/dev/null | wc -l | tr -d ' ')
if [ "$pane_count" != "1" ]; then
  exit 0
fi

# Start btop in the first pane for the very first session.
tmux send-keys -t "${window_id}.1" "btop" C-m
# Focus the pane after sending the command so it remains active.
tmux select-pane -t "${window_id}.1"
