#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Installing helper scripts ... Skipped'
	exit
fi

while read line; do
	if need_skip_line "$line"; then
		continue
	fi

	ln -sf $SCRIPT_ROOT/$line $bin/$line
done <$CONFIG_ROOT/helper.list

mark_init_done
info 'Installing helper scripts ... OK'
