#!/usr/bin/env bash

_systemd_internal() {
	local cmd="$1"
	local unit="$2"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		source /tmp/belt/tools/systemd/systemd.sh
		"$cmd" "$unit"
	SCRIPT
}

systemd_get_logs() {
	_systemd_internal "${FUNCNAME[0]}" "$@"
}
