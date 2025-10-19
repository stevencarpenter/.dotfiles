#!/usr/bin/env bash
set -euo pipefail

# Determine the window associated with the pane where the key binding was triggered.
current_window=$(tmux display-message -p -t "$TMUX_PANE" "#{window_id}")
if [ -z "$current_window" ]; then
  exit 0
fi

base_index=$(tmux show-option -gv pane-base-index 2>/dev/null || echo 0)

mapfile -t panes < <(tmux list-panes -t "$current_window" -F "#{pane_id}")
for i in "${!panes[@]}"; do
  pane_id="${panes[$i]}"
  target_index=$((base_index + i))
  current_index=$(tmux display-message -p -t "$pane_id" "#{pane_index}")
  if [ "$current_index" -eq "$target_index" ]; then
    continue
  fi
  tmux move-pane -s "$pane_id" -t "${current_window}.${target_index}"
done

tmux display-message "Renumbered panes"
