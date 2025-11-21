#!/usr/bin/env bash
set -e

DEV_UID="${DEV_UID:-1000}"
DEV_GID="${DEV_GID:-1000}"
DEV_USER="${DEV_USER:-dev}"
DEV_HOME="${DEV_HOME:-/home/${DEV_USER}}"
DEV_SHELL="${DEV_SHELL:-/bin/zsh}"

group_name="$DEV_USER"
if ! getent group "$DEV_GID" >/dev/null 2>&1; then
  groupadd -g "$DEV_GID" "$group_name" 2>/dev/null || group_name="devgroup"
fi

if id -u "$DEV_USER" >/dev/null 2>&1; then
  usermod -u "$DEV_UID" -g "$DEV_GID" "$DEV_USER"
else
  useradd -m -d "$DEV_HOME" -s "$DEV_SHELL" -u "$DEV_UID" -g "$DEV_GID" "$DEV_USER"
fi

mkdir -p "$DEV_HOME" /work
chown -R "$DEV_UID":"$DEV_GID" "$DEV_HOME"
chown "$DEV_UID":"$DEV_GID" /work

export HOME="$DEV_HOME"
export USER="$DEV_USER"
exec gosu "$DEV_UID:$DEV_GID" "$@"
