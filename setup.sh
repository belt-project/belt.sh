#!/usr/bin/env bash
set -e

export BELT_REPO="https://github.com/belt-sh/belt.sh"
export BELT_VERSION="master"
export BELT_LIB="/usr/local/lib/belt/$BELT_VERSION"

abort() {
  local ret=$?
  echo "$1"
  exit $ret
}

setup() {
  if ! [ -d "$BELT_LIB" ]; then
    echo "Installing belt.sh..."
    git clone -b "$BELT_VERSION" "$BELT_REPO" "$BELT_LIB" &>/dev/null || abort "git clone failed"
  elif [ "$BELT_VERSION" = "master" ]; then
    echo "Updating belt.sh..."
    git -C "$BELT_LIB" pull &>/dev/null || abort "git pull failed"
  fi
}

setup

# shellcheck source=./belt.sh
source "$BELT_LIB/belt.sh"
