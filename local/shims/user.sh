#!/usr/bin/env bash

user_add() {
	local user="$1"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		adduser --no-create-home --disabled-login "$1" &>/dev/null
	SCRIPT
}
