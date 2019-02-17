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

systemctl_start() {
	_systemd_internal "${FUNCNAME[0]}" "$@"
}

systemctl_stop() {
	_systemd_internal "${FUNCNAME[0]}" "$@"
}

systemd_add_unit() {
	local unit="$1"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		cp "$_BELT_ARCHIVE_EXTRACTED_PATH/$unit" "\$BELT_SYSTEMD_DIR/$_BELT_APP_NAME.service"
		systemctl_reload
		systemctl_enable "$_BELT_APP_NAME.service"
	SCRIPT
}
