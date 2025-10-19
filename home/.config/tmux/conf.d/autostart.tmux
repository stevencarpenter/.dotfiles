# Automatically launch btop in the very first tmux session.
set-hook -g session-created 'run-shell "~/.config/tmux/scripts/autostart-btop.sh #{hook_session_id}"'
