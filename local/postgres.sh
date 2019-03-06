#!/usr/bin/env bash

_postgres_internal() {
	local cmd="$1"
	shift
	local args="$@"

	belt_remote_exec <<-SCRIPT
		source /tmp/belt/env.sh
		source /tmp/belt/lib/postgres.sh
		"$cmd" $args
	SCRIPT
}

postgres_install() {
	_postgres_internal "${FUNCNAME[0]}"
}

postgres_psql_exec() {
	_postgres_internal "${FUNCNAME[0]}" "$@"
}

postgres_create_database() {
	_postgres_internal "${FUNCNAME[0]}" "$@"
}

postgres_create_role() {
	_postgres_internal "${FUNCNAME[0]}" "$@"
}

postgres_add_role_to_db() {
	_postgres_internal "${FUNCNAME[0]}" "$@"
}
