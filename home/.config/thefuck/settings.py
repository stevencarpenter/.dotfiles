"""Opinionated configuration for thefuck.

The defaults shipped with the project are all commented out in the example
config; keeping them uncommented makes it hard to see what is actually in
use.  This file keeps the frequently tuned options explicit so behaviour is
predictable across machines.
"""

from __future__ import annotations

from pathlib import Path

# Promptless corrections keep the workflow quick while still allowing
# history to reflect what actually ran.
require_confirmation = False
alter_history = True

# Tweak performance-oriented settings.
wait_command = 3
wait_slow_command = 15
slow_commands = [
    "lein",
    "react-native",
    "gradle",
    "./gradlew",
    "vagrant",
]

# Offer a few more candidates when typos are ambiguous.
num_close_matches = 5

# Enable instant mode when the shell alias has been set up.
instant_mode = True

# Keep the command history manageable and portable across shells.
history_limit = 2000

# Avoid rewriting commands run against transient cache directories.
excluded_search_path_prefixes = [
    str(Path.home() / ".cache"),
    "/tmp",
]

# Ensure commands run in a predictable locale.
env = {
    "LC_ALL": "C.UTF-8",
    "LANG": "C.UTF-8",
}
