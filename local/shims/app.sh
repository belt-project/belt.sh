#!/usr/bin/env bash

app_setup() {
	local path="$1"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		mkdir -p "/app/$_BELT_APP_NAME"
		cp -R "$_BELT_ARCHIVE_EXTRACTED_PATH/$path" "/app/$_BELT_APP_NAME"
	SCRIPT
}
