#!/usr/bin/env bash

export _BELT_SSH_USER
export _BELT_SSH_HOST
export _BELT_SSH_PORT

export _BELT_REMOTE_LIB_PATH

export _BELT_TOOLBOX_TMP_PATH

belt_cleanup_session() {
	rm -rf "$_BELT_TOOLBOX_TMP_PATH"
	belt_remote_exec "rm -rf $_BELT_REMOTE_LIB_PATH $BELT_ARCHIVE_PATH $BELT_ARCHIVE_EXTRACTED_PATH"
}

belt_begin_session() {
	trap belt_cleanup_session EXIT INT

	_BELT_SSH_USER="$1"
	_BELT_SSH_HOST="$2"
	_BELT_SSH_PORT="${3:-22}"

	_BELT_REMOTE_LIB_PATH="/tmp/$(basename "$(mktemp -u)")"

	ssh -p "$_BELT_SSH_PORT" "$_BELT_SSH_USER@$_BELT_SSH_HOST" "mkdir -p $_BELT_REMOTE_LIB_PATH"

	if [[ -n "$BELT_TOOLBOX_TOOLS" ]]; then
		_BELT_TOOLBOX_TMP_PATH="/tmp/$(basename "$(mktemp -u)")"

		_belt_upload_remote_toolbox
	fi
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
		ssh -p "$_BELT_SSH_PORT" "$_BELT_SSH_USER@$_BELT_SSH_HOST" "cd $_BELT_REMOTE_LIB_PATH && ls -la toolbox && bash -s" <<-SCRIPT
			$script
		SCRIPT
	else
		ssh -p "$_BELT_SSH_PORT" "$_BELT_SSH_USER@$_BELT_SSH_HOST" "cd $_BELT_REMOTE_LIB_PATH && ls -la toolbox && bash -s" "$script"
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

_belt_upload_remote_toolbox() {
	IFS=',' read -ra PLUGINS <<< "$BELT_TOOLBOX_TOOLS"
	unset IFS

	# shellcheck disable=SC1090
	for plugin in "${PLUGINS[@]}"; do
		mkdir -p "$_BELT_TOOLBOX_TMP_PATH/$plugin"

		if [[ -d "$BELT_TOOLBOX_PATH/$plugin/remote" ]]; then
			cp -r "$BELT_TOOLBOX_PATH/$plugin/remote/" "$_BELT_TOOLBOX_TMP_PATH/$plugin/"
		fi
	done

	belt_remote_upload "$_BELT_TOOLBOX_TMP_PATH" "$_BELT_REMOTE_LIB_PATH/toolbox"
}

_belt_load_lib() {
	# shellcheck disable=SC1090
	for file in "$BELT_PATH"/lib/*.sh; do source "$file"; done
}

_belt_load_toolbox() {
	if [[ -n "$BELT_TOOLBOX_TOOLS" ]]; then
		IFS=',' read -ra PLUGINS <<< "$BELT_TOOLBOX_TOOLS"
		unset IFS

		# shellcheck disable=SC1090
		for plugin in "${PLUGINS[@]}"; do
			if [[ ! -d "$BELT_TOOLBOX_PATH/$plugin" ]]; then
				belt_abort "plugin does not exist: $plugin"
			fi

			source "$BELT_TOOLBOX_PATH/$plugin/local/plugin.sh"
		done
	fi
}

_belt_load_lib
_belt_load_toolbox
