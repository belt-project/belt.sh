#!/usr/bin/env bash

systemctl_reload() {
  systemctl daemon-reload &>/dev/null
}

systemctl_enable() {
	local service="$1"
	systemctl enable "$service" &>/dev/null
}

systemctl_disable() {
	local service="$1"
	systemctl disable "$service" &>/dev/null
}

systemctl_start() {
	local service="$1"
	systemctl start "$service" &>/dev/null
}

systemctl_stop() {
	local service="$1"
	systemctl stop "$service" &>/dev/null
}

systemctl_restart() {
	local service="$1"
	systemctl restart "$service" &>/dev/null
}
