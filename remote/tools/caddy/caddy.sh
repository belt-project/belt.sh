#!/usr/bin/env bash

export CADDY_BINARY="/usr/local/bin/caddy"
export CADDY_CONFIG_DIR="/etc/caddy"
export CADDY_SSL_DIR="/etc/ssl/caddy"
export CADDY_SERVICE_FILE="$BELT_SYSTEMD_DIR/caddy.service"
export CADDY_SERVICE="caddy.service"

caddy_install() {
	if system_command_exists "caddy"; then
		return 0
	fi

	(curl -s https://getcaddy.com | bash -s personal &>/dev/null) || system_abort "caddy install failed"

	chown root:root "$CADDY_BINARY"
	chmod 755 "$CADDY_BINARY"

	setcap 'cap_net_bind_service=+eip' "$CADDY_BINARY"

	mkdir -p "$CADDY_CONFIG_DIR/vhosts"
	chown -R root:www-data "$CADDY_CONFIG_DIR"

	mkdir -p "$CADDY_SSL_DIR"
	chown -R www-data:root "$CADDY_SSL_DIR"
	chmod 770 "$CADDY_SSL_DIR"

	cp "$BELT_TOOLS_PATH/caddy/Caddyfile" "$CADDY_CONFIG_DIR/Caddyfile"

	cp "$BELT_TOOLS_PATH/caddy/caddy.service" "$CADDY_SERVICE_FILE"
	chown root:root "$CADDY_SERVICE_FILE"
	chmod 744 "$CADDY_SERVICE_FILE"

	systemd_reload || system_abort "systemd reload failed"

	systemd_unit_enable "$CADDY_SERVICE" || system_abort "systemd enable failed"
}

caddy_uninstall() {
	if system_process_running "caddy"; then
		caddy_stop
	fi

	systemd_unit_disable "$CADDY_SERVICE" || true

	rm -fr "$CADDY_BINARY" "$CADDY_CONFIG_DIR" "$CADDY_SSL_DIR" "$CADDY_SERVICE_FILE" &>/dev/null
}

caddy_start() {
	systemd_unit_start "$CADDY_SERVICE" || system_abort "caddy start failed"
}

caddy_stop() {
	systemd_unit_stop "$CADDY_SERVICE" || system_abort "caddy stop failed"
}

caddy_restart() {
	systemd_unit_restart "$CADDY_SERVICE" || system_abort "caddy restart failed"
}
