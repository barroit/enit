#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Installing pipx packages ... Skipped'
	exit
fi

# 'which -s' behaves strange on macos
if ! which pipx >/dev/null; then
	die "can't find pipx in current environment"
fi

while read line; do
	if need_skip_line "$line"; then
		continue
	fi

	pipx install $line
done < $vartree/pip.list

mark_init_done
info 'Installing pipx packages ... OK'
