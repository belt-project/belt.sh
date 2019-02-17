#!/usr/bin/env bash

app_copy_files() {
	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		mkdir -p "/app/$_BELT_APP_NAME"
		for file in $@; do
			cp "$_BELT_ARCHIVE_EXTRACTED_PATH/\$file" "/app/$_BELT_APP_NAME/"
		done
	SCRIPT
}

app_copy_directories() {
	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		mkdir -p "/app/$_BELT_APP_NAME"
		for dir in $@; do
			cp -a "$_BELT_ARCHIVE_EXTRACTED_PATH/\$dir/." "/app/$_BELT_APP_NAME/"
		done
	SCRIPT
}

app_setup_permissions() {
	local user="$1"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		chown -R "$user" "/app/$_BELT_APP_NAME"
		chmod -R 770 "/app/$_BELT_APP_NAME"
	SCRIPT
}
