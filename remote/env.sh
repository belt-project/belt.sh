#!/usr/bin/env bash

export BELT_PATH="/tmp/belt"
export BELT_TOOLS_PATH="$BELT_PATH/tools"

export BELT_SYSTEMD_DIR="/etc/systemd/system"

# shellcheck disable=SC1090
for lib in "$BELT_PATH"/lib/*.sh; do source "$lib"; done
