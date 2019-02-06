#!/usr/bin/env bash

for tool in "$BELT_LIB"/tools/*.sh; do
  [ -e "$tool" ] || continue

  # shellcheck disable=SC1090
  source "$tool"
done
