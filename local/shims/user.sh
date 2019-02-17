#!/usr/bin/env bash

user_add() {
	local user="$1"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		id -u "$user" &>/dev/null || adduser --no-create-home --disabled-login "$user" &>/dev/null
	SCRIPT
}
