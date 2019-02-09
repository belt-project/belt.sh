#!/usr/bin/env bash

systemd_reload() {
  systemctl daemon-reload &>/dev/null
}

systemd_enable() {
	local service="$1"
	systemctl enable "$service" &>/dev/null
}

systemd_disable() {
	local service="$1"
	systemctl disable "$service" &>/dev/null
}

systemd_start() {
	local service="$1"
	systemctl start "$service" &>/dev/null
}

systemd_stop() {
	local service="$1"
	systemctl stop "$service" &>/dev/null
}

systemd_restart() {
	local service="$1"
	systemctl restart "$service" &>/dev/null
}
