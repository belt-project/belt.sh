#!/usr/bin/env bash

app_upload() {
	local src="$1"
	archive_upload "$src"
}

app_copy_file() {
	local src="$1"
	archive_copy_file "$src" "/app/$BELT_ARCHIVE_BASENAME"
}

app_copy_directory() {
	local src="$1"
	archive_copy_directory "$src" "/app/$BELT_ARCHIVE_BASENAME"
}

app_set_permissions() {
	local user="$1"

	belt_remote_exec <<-SCRIPT
		chown -R "$user" "/app/$BELT_ARCHIVE_BASENAME"
		chmod -R 770 "/app/$BELT_ARCHIVE_BASENAME"
	SCRIPT
}
