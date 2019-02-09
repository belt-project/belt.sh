#!/usr/bin/env bash

systemd_get_logs() {
	local unit="$1"

	echo "$1"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		source /tmp/belt/tools/systemd/systemd.sh
		systemd_get_logs "$unit"
	SCRIPT
}
