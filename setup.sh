#!/usr/bin/env bash
set -e

export BELT_REPO="https://github.com/belt-sh/belt.sh"
export BELT_VERSION="master"
export BELT_LIB_PREFIX="/usr/local/lib"
export BELT_LIB="$BELT_LIB_PREFIX/belt/$BELT_VERSION"

bootstrap_abort() {
	local msg="$1"
	echo "belt: $msg"
	exit 1
}

bootstrap_install() {
	git clone -b "$BELT_VERSION" "$BELT_REPO" "$BELT_LIB" &>/dev/null || bootstrap_abort "git clone failed"
}

bootstrap_update() {
	git -C "$BELT_LIB" pull &>/dev/null || bootstrap_abort "git pull failed"
}

bootstrap() {
	if [[ ! -x "$(command -v git)" ]]; then
		bootstrap_abort "git not found"
	fi

	if [[ -d "$BELT_LIB" ]]; then
		if [[ "$BELT_VERSION" = "master" || ! "$BELT_VERSION" =~ ^v ]]; then
			echo "Updating belt.sh..."
			bootstrap_update
		fi
	fi

	if [[ ! -d "$BELT_LIB" ]]; then
		echo "Installing belt.sh..."
		bootstrap_install
	fi
}

bootstrap

# shellcheck disable=SC1090
source "$BELT_LIB/belt.sh"
