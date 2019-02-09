#!/usr/bin/env bash

systemd_get_logs() {
	local unit="$1"
	journalctl -u "$unit" --no-tail
}
