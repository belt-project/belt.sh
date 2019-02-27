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
		chown -R "$user" "/app/$_BELT_APP_NAME"
		chmod -R 770 "/app/$_BELT_APP_NAME"
	SCRIPT
}
