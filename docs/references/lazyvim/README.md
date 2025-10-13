# LazyVim snapshots removed from docs

To keep the documentation concise, the upstream LazyVim Lua snapshot files that used to live under this directory have been removed from the repository.

- A single, consolidated Neovim keymap reference now lives at `docs/neovim-hotkeys.md`.
- If you need the original upstream Lua source for LazyVim, please consult the LazyVim repository at https://github.com/LazyVim/LazyVim or retrieve past snapshots from this project's git history.

Rationale:
- The docs should be a lightweight, human-readable reference (markdown) rather than a copy of upstream source code.
- Local overrides and additions are documented at the top of `docs/neovim-hotkeys.md` so you can quickly find what differs from the defaults.

If you want to restore any of the original snapshots into docs locally, re-add the files or copy the content from upstream or the project history.