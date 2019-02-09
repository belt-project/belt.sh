#!/usr/bin/env bash

caddy_install() {
	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		source /tmp/belt/tools/caddy/caddy.sh
		caddy_install
	SCRIPT
}

caddy_uninstall() {
	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		source /tmp/belt/tools/caddy/caddy.sh
		caddy_uninstall
	SCRIPT
}

caddy_start() {
	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		source /tmp/belt/tools/caddy/caddy.sh
		caddy_start
	SCRIPT
}

caddy_stop() {
	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		source /tmp/belt/tools/caddy/caddy.sh
		caddy_stop
	SCRIPT
}

caddy_restart() {
	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		source /tmp/belt/tools/caddy/caddy.sh
		caddy_restart
	SCRIPT
}
