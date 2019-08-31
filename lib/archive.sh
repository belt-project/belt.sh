#!/usr/bin/env bash

export BELT_ARCHIVE_BASENAME
export BELT_ARCHIVE_PATH
export BELT_ARCHIVE_EXTRACTED_PATH

archive_upload() {
	local src="$1"
	local dest="$2"

	BELT_ARCHIVE_BASENAME=$(basename "$src" .tar.gz)
	BELT_ARCHIVE_PATH="/tmp/$(basename "$src")"
	BELT_ARCHIVE_EXTRACTED_PATH="${dest:-"/tmp/$BELT_ARCHIVE_BASENAME-belt"}"

	belt_remote_upload "$src" "$BELT_ARCHIVE_PATH"

	belt_remote_exec <<-SCRIPT
		mkdir -p "$BELT_ARCHIVE_EXTRACTED_PATH"
		tar -zxf "$BELT_ARCHIVE_PATH" -C "$BELT_ARCHIVE_EXTRACTED_PATH"
	SCRIPT

	if [[ -n $dest ]]; then
		BELT_ARCHIVE_EXTRACTED_PATH=""
	fi
}

archive_copy_file() {
	[[ -z $BELT_ARCHIVE_EXTRACTED_PATH ]] \
		&& belt_abort "cannot copy file when archive upload destination is set"

	local src="$1"
	local dest="$2"

	belt_remote_exec <<-SCRIPT
		mkdir -p "$dest"
		cp "$BELT_ARCHIVE_EXTRACTED_PATH/$src" "$dest/"
	SCRIPT
}

archive_copy_directory() {
	[[ -z $BELT_ARCHIVE_EXTRACTED_PATH ]] \
		&& belt_abort "cannot copy file when archive upload destination is set"

	local src="$1"
	local dest="$2"

	belt_remote_exec <<-SCRIPT
		mkdir -p "$dest"
		cp -a "$BELT_ARCHIVE_EXTRACTED_PATH/$src/." "$dest/"
	SCRIPT
}
