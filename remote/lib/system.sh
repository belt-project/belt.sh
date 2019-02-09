#!/usr/bin/env bash

system_abort() {
	local msg="$1"
	echo "belt: $msg"
	exit 1
}

system_command_exists() {
	local cmd="$1"

  if [ -x "$(command -v "$cmd")" ]; then
    return 0
  fi

  return 1
}
