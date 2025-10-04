#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Installing apt packages ... Skipped'
	exit
fi

sudo apt update

while read line; do
	name=$(linecol_1 "$line")
	type=$(linecol_2 "$line")

	case $type in
	'd')
		if test_vm; then
			continue
		fi
		;;
	'v')
		if ! test_vm; then
			continue
		fi
	esac

	sudo apt install -y $name
done < $CONFIG_ROOT/apt.list

mark_init_done
info 'Installing apt packages ... OK'
