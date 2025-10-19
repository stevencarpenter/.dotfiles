# Reload tmux configuration quickly.
unbind r
bind r source-file "~/.config/tmux/tmux.conf" \; display-message "Reloaded tmux.conf"

# Navigate panes with vim-like bindings.
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R

# Split panes using |- style shortcuts.
unbind '"'
unbind %
bind | split-window -h
bind - split-window -v

# Window navigation shortcuts.
bind C-p previous-window
bind C-n next-window

# Renumber panes in the current window to fill any gaps.
bind R run-shell '~/.config/tmux/scripts/renumber-panes.sh'
