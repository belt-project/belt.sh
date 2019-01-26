#!/usr/bin/env bash
set -e

export BELT_LIB="/usr/local/lib/belt.sh"
export BELT_REPO="https://github.com/belt-sh/belt.sh"

function abort {
  local ret=$?
  echo "$1"
  exit $ret
}

function log {
  echo "$1"
}

function ok {
  echo "==> $1"
}

if [ ! -d "$BELT_LIB" ]; then
  log "Installing belt.sh..."
  git clone "$BELT_REPO" "$BELT_LIB" &>/dev/null || abort "git clone failed"
  ok "Installed belt.sh"
  echo
fi

# shellcheck source=./belt.sh
source "$BELT_LIB/belt.sh"
