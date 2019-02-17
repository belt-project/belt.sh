#!/usr/bin/env bash

systemd_reload() {
	systemctl daemon-reload &>/dev/null
}

systemd_unit_enable() {
	local unit="$1"
	systemctl enable "$unit" &>/dev/null
}

systemd_unit_disable() {
	local unit="$1"
	systemctl disable "$unit" &>/dev/null
}

systemd_unit_start() {
	local unit="$1"
	systemctl start "$unit" &>/dev/null
}

systemd_unit_stop() {
	local unit="$1"
	systemctl stop "$unit" &>/dev/null
}

systemd_unit_restart() {
	local unit="$1"
	systemctl restart "$unit" &>/dev/null
}

systemd_unit_logs() {
	local unit="$1"
	journalctl -u "$unit" --no-tail
}
