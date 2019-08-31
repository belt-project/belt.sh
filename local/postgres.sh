#!/usr/bin/env bash

_postgres_internal() {
	local cmd="$1"
	shift
	local args="$@"

	belt_remote_exec <<-SCRIPT
		source "$_BELT_REMOTE_LIB_PATH/env.sh"
		source "$_BELT_REMOTE_LIB_PATH/lib/postgres.sh"
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
