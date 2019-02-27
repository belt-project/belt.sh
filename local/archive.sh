#!/usr/bin/env bash

export _BELT_ARCHIVE_NAME
export _BELT_ARCHIVE_PATH
export _BELT_ARCHIVE_EXTRACTED_PATH

archive_upload() {
	local src="$1"
	local dest="$2"

	_BELT_ARCHIVE_BASENAME=$(basename "$src" .tar.gz)
	_BELT_ARCHIVE_PATH="/tmp/$(basename "$src")"
	_BELT_ARCHIVE_EXTRACTED_PATH="${dest:-"/tmp/$_BELT_ARCHIVE_BASENAME-belt"}"

	belt_remote_upload "$src" "$_BELT_ARCHIVE_PATH"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		mkdir -p "$_BELT_ARCHIVE_EXTRACTED_PATH"
		tar -zxf "$_BELT_ARCHIVE_PATH" -C "$_BELT_ARCHIVE_EXTRACTED_PATH"
	SCRIPT

	[[ -n $dest ]] && _BELT_ARCHIVE_EXTRACTED_PATH=""
}

archive_copy_file() {
	[[ -z $_BELT_ARCHIVE_EXTRACTED_PATH ]] \
		&& belt_abort "cannot copy file when archive upload destination is set"

	local src="$1"
	local dest="$2"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		mkdir -p "$dest"
		cp "$_BELT_ARCHIVE_EXTRACTED_PATH/$src" "$dest/"
	SCRIPT
}

archive_copy_directory() {
	[[ -z $_BELT_ARCHIVE_EXTRACTED_PATH ]] \
		&& belt_abort "cannot copy file when archive upload destination is set"

	local src="$1"
	local dest="$2"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		mkdir -p "$dest"
		cp -a "$_BELT_ARCHIVE_EXTRACTED_PATH/$src/." "$dest/"
	SCRIPT
}
