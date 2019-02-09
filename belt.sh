#!/usr/bin/env bash

export _BELT_SSH_USER
export _BELT_SSH_HOST
export _BELT_SSH_PORT

# shellcheck disable=SC1090
for file in "$BELT_LIB"/internal/*.sh; do source "$file"; done

# shellcheck disable=SC1090
for file in "$BELT_LIB"/shims/*.sh; do source "$file"; done

belt_begin_session() {
	trap belt_cleanup_session EXIT

  _BELT_SSH_USER="$1"
  _BELT_SSH_HOST="$2"
  _BELT_SSH_PORT="${3:-22}"

	belt_cleanup_session
	belt_remote_upload "$BELT_LIB/remote" "/tmp/belt"
}

belt_cleanup_session() {
	belt_remote_exec "rm -rf /tmp/belt"
}
