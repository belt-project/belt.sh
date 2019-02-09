#!/usr/bin/env bash

export _BELT_SSH_USER
export _BELT_SSH_HOST
export _BELT_SSH_PORT

# shellcheck disable=SC1090
for file in "$BELT_LIB"/internal/*.sh; do source "$file"; done

# shellcheck disable=SC1090
for file in "$BELT_LIB"/shims/*.sh; do source "$file"; done

belt_begin_session() {
  _BELT_SSH_USER="$1"
  _BELT_SSH_HOST="$2"
  _BELT_SSH_PORT="${3:-22}"

	local local_dir="$BELT_LIB/remote"
	local remote_dir="$_BELT_SSH_USER@$_BELT_SSH_HOST:/tmp/belt"

	scp -P "$_BELT_SSH_PORT" -r "$local_dir" "$remote_dir" &>/dev/null || belt_abort "library upload failed"
}

belt_end_session() {
	belt_remote_exec "rm -rf /tmp/belt"
}
