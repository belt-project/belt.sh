#!/usr/bin/env bash

systemd_unit_logs() {
	local unit="$1"
	belt_remote_exec "journalctl -u \"$unit\" --no-tail"
}

systemd_unit_start() {
	local unit="$1"
	belt_remote_exec "systemctl start \"$unit\" &>/dev/null"
}

systemd_unit_stop() {
	local unit="$1"
	local ignore_errors="$2"

	if [[ -n "$ignore_errors" ]]; then
		belt_remote_exec "systemctl stop \"$unit\" &>/dev/null || true"
	else
		belt_remote_exec "systemctl stop \"$unit\" &>/dev/null"
	fi
}

systemd_unit_restart() {
	local unit="$1"
	belt_remote_exec "systemctl restart \"$unit\" &>/dev/null"
}

systemd_daemon_reload() {
	local unit="$1"
	belt_remote_exec "systemctl daemon-reload &>/dev/null"
}

systemd_add_unit() {
	local unit="$1"

	belt_remote_exec <<-SCRIPT
		cp "$BELT_ARCHIVE_EXTRACTED_PATH/$unit" "/etc/systemd/system/$BELT_ARCHIVE_BASENAME.service"
		systemctl daemon-reload &>/dev/null
		systemctl enable "$BELT_ARCHIVE_BASENAME.service" &>/dev/null
	SCRIPT
}
