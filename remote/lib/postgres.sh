#!/usr/bin/env bash

postgres_install() {
	if command_exists "psql"; then
		return 0
	fi

	curl -s https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - &>/dev/null \
		|| abort "postgres apt-key add failed"

	sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" > /etc/apt/sources.list.d/PostgreSQL.list' \
		|| abort "postgres add sources.list failed"

	apt update &>/dev/null || abort "apt update failed"

	apt install --yes postgresql-11 &>/dev/null || abort "postgres apt install failed"
}

postgres_psql_exec() {
	local cmd="$1"
	cd /usr/lib/postgresql && sudo -u postgres psql -c "$cmd"
}

postgres_create_database() {
	local db="$1"
	postgres_psql_exec "CREATE DATABASE $db;" &>/dev/null || abort "postgres create database failed"
}

postgres_create_role() {
	local role="$1"
	local password="$2"

	postgres_psql_exec "CREATE USER $role WITH ENCRYPTED PASSWORD '$password';" &>/dev/null \
		|| abort "postgres create role failed"
}

postgres_add_role_to_db() {
	local role="$1"
	local db="$2"

	postgres_psql_exec "GRANT ALL PRIVILEGES ON DATABASE $db TO $role;" &>/dev/null \
		|| abort "postgres grant all failed"
}
