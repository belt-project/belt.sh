#!/usr/bin/env bash

hello() {
	local name="$1"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/tools/hello/hello.sh
		hello "$name"
	SCRIPT
}
