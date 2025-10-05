#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

if ! command -v pipx >/dev/null; then
	die "pipx's missing in current shell execution environment"
fi

trap 'rm -f package.tmp' EXIT
pipx list --short >package.tmp

while read line; do
	if need_skip_line "$line"; then
		continue
	fi

	if grep -qi $line package.tmp; then
		continue
	fi

	pipx install $line
done <$vartree/package.pip

info 'Installing pipx packages ... OK'
