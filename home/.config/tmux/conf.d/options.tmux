# Global options
unbind C-b
set -g prefix C-Space
set -g mouse on
set-option -g status-position top
set -s escape-time 0
set -g history-limit 1000000
set -g display-time 4000
set -g status-interval 5
set -g focus-events on
setw -g aggressive-resize on
set -g base-index 1
setw -g pane-base-index 1
set -g renumber-windows on
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ',xterm-256color:Tc'
