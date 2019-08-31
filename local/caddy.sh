#!/usr/bin/env bash

_caddy_internal() {
	local cmd="$1"

	belt_remote_exec <<-SCRIPT
		source "$_BELT_REMOTE_LIB_PATH/env.sh"
		source "$_BELT_REMOTE_LIB_PATH/lib/systemd.sh"
		source "$_BELT_REMOTE_LIB_PATH/lib/caddy.sh"
		"$cmd"
	SCRIPT
}

caddy_install() {
	_caddy_internal "${FUNCNAME[0]}"
}

caddy_uninstall() {
	_caddy_internal "${FUNCNAME[0]}"
}

caddy_start() {
	_caddy_internal "${FUNCNAME[0]}"
}

caddy_stop() {
	_caddy_internal "${FUNCNAME[0]}"
}

caddy_restart() {
	_caddy_internal "${FUNCNAME[0]}"
}
