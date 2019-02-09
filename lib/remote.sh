#!/usr/bin/env bash

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
