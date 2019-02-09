#!/usr/bin/env bash

export BELT_PATH="/tmp/belt"

# shellcheck disable=SC1090
for lib in "$BELT_PATH"/lib/*.sh; do source "$lib"; done
