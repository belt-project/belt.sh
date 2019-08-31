#!/usr/bin/env bash

export BELT_PATH="$(pwd)"
export BELT_LIB_PATH="$BELT_PATH/lib"
export BELT_SYSTEMD_PATH="/etc/systemd/system"

abort() {
	local msg="$1"
	echo "belt: $msg"
	exit 1
}

command_exists() {
	local cmd="$1"

	if [ -x "$(command -v "$cmd")" ]; then
		return 0
	fi

	return 1
}

process_running() {
	local name="$1"
	ps -C "$name" &>/dev/null
	return $?
}
