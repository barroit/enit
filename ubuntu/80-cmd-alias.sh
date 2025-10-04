#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Aliasing commands ... Skipped'
	exit
fi

touch ~/.bash_aliases

while read line; do
	if [[ ! $line || $line == '#'* ]]; then
		continue
	fi

	name=$(linecol_1 "$line")
	cmd=$(linecol_2 "$line")
	prefix="alias $name"

	if grep -q "$prefix=" ~/.bash_aliases; then
		sed -i "s|^$prefix='.*'$|$prefix='$cmd'|" ~/.bash_aliases
	else
		printf '\n%s\n' "$prefix='$cmd'" >> ~/.bash_aliases
	fi
done < $vartree/cmd-alias

mark_init_done
info 'Aliasing commands ... OK'
