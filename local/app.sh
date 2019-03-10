#!/usr/bin/env bash

app_upload() {
	local src="$1"
	archive_upload "$src"
}

app_copy_files() {
	local src="$1"
	archive_copy_file "$src" "/app/$_BELT_ARCHIVE_BASENAME"
}

app_copy_directory() {
	local src="$1"
	archive_copy_directory "$src" "/app/$_BELT_ARCHIVE_BASENAME"
}

app_set_permissions() {
	local user="$1"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		chown -R "$user" "/app/$_BELT_ARCHIVE_BASENAME"
		chmod -R 770 "/app/$_BELT_ARCHIVE_BASENAME"
	SCRIPT
}

app_add_caddy_vhost() {
	local vhost="${1:-"Caddyfile"}"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		source /tmp/belt/lib/caddy.sh
		cp "$_BELT_ARCHIVE_EXTRACTED_PATH/$vhost" "\$CADDY_CONFIG_DIR/vhosts/$_BELT_ARCHIVE_BASENAME.caddy"
	SCRIPT
}
