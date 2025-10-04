#!/bin/zsh
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Configuring Zsh key bindings ... Skipped'
	exit
fi

touch ~/.zshrc

while read line; do
	if [[ ! $line || $line = '#'* ]]; then
		continue
	fi

	if grep -Fxq "$line" ~/.zshrc; then
		continue
	fi

	printf '\n%s\n' "$line" >> ~/.zshrc

done < $vartree/zsh-key-binding

mark_init_done
info 'Configuring Zsh key bindings ... OK'
