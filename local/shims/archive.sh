#!/usr/bin/env bash

export _BELT_APP_NAME
export _BELT_ARCHIVE_PATH
export _BELT_ARCHIVE_EXTRACTED_PATH

archive_upload() {
	local path="$1"

	_BELT_APP_NAME=$(basename "$path" .tar.gz)
	_BELT_ARCHIVE_PATH="/tmp/$(basename $path)"
	_BELT_ARCHIVE_EXTRACTED_PATH="/tmp/$_BELT_APP_NAME-belt"

	belt_remote_upload "$path" "$_BELT_ARCHIVE_PATH"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		mkdir -p "$_BELT_ARCHIVE_EXTRACTED_PATH"
		tar -zxf "$_BELT_ARCHIVE_PATH" -C "$_BELT_ARCHIVE_EXTRACTED_PATH"
	SCRIPT
}
