#!/usr/bin/env bash

belt_abort() {
	local msg="$1"
	echo "belt: $msg"
	exit 1
}
