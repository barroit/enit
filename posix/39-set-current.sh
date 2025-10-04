#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

name=$(basename $ctree)

if ! test_force_run && test_init_done; then
	info "Linking \`$name' to 'current' ... Skipped"
	exit
fi

ln -snf $name current

mark_init_done
info "Linking \`$name' to 'current' ... OK"
