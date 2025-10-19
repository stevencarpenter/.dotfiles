# Plugin manager configuration
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'TanglingTreats/tmux-everforest'
set -g @tmux-everforest 'dark-medium'

# Only attempt to bootstrap TPM if it exists.
if-shell '[ -d "${XDG_CONFIG_HOME:-$HOME/.config}/tmux/plugins/tpm" ]' \
    'run "${XDG_CONFIG_HOME:-$HOME/.config}/tmux/plugins/tpm/tpm"'
