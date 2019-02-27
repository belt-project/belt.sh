#!/usr/bin/env bash

export _BELT_SSH_USER
export _BELT_SSH_HOST
export _BELT_SSH_PORT

# shellcheck disable=SC1090
for file in "$BELT_LIB"/local/*.sh; do source "$file"; done

belt_begin_session() {
	trap belt_cleanup_session EXIT INT

	_BELT_SSH_USER="$1"
	_BELT_SSH_HOST="$2"
	_BELT_SSH_PORT="${3:-22}"

	belt_cleanup_session
	belt_remote_upload "$BELT_LIB/remote" "/tmp/belt"
}

belt_cleanup_session() {
	belt_remote_exec "rm -rf /tmp/belt $_BELT_ARCHIVE_PATH $_BELT_ARCHIVE_EXTRACTED_PATH"
}

belt_abort() {
	local msg="$1"
	echo "belt: $msg"
	exit 1
}

belt_remote_exec() {
	local script="$1"

	# Temporarily turn off exit on error.
	set +e

	if [[ -n "$script" ]]; then
		ssh -p "$_BELT_SSH_PORT" "$_BELT_SSH_USER@$_BELT_SSH_HOST" "bash -s" <<-SCRIPT
			$script
		SCRIPT
	else
		ssh -p "$_BELT_SSH_PORT" "$_BELT_SSH_USER@$_BELT_SSH_HOST" "bash -s" "$script"
	fi

	# shellcheck disable=SC2181
	if [[ $? -ne 0 ]]; then
		belt_abort "remote exec failed"
	fi

	# Re-enable exit on error.
	set -e
}

belt_remote_upload() {
	local source="$1"
	local target="$2"

	scp -P "$_BELT_SSH_PORT" -r "$source" "$_BELT_SSH_USER@$_BELT_SSH_HOST:$target" &>/dev/null \
		|| belt_abort "remote upload failed"
}
