#!/usr/bin/env bash

_caddy_internal() {
	local cmd="$1"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		source /tmp/belt/tools/caddy/caddy.sh
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

caddy_add_vhost() {
	local vhost="${1:-"Caddyfile"}"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		source /tmp/belt/tools/caddy/caddy.sh
		cp "$_BELT_ARCHIVE_EXTRACTED_PATH/$vhost" "\$CADDY_CONFIG_DIR/vhosts/$_BELT_APP_NAME.caddy"
	SCRIPT
}
