#!/bin/zsh
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Installing homebrew packages ... Skipped'
	exit
fi

brew update
touch ~/.zshrc

while read line; do
	if [[ ! $line || $line == '#'* ]]; then
		continue
	fi

	name=$(linecol_1 "$line")
	cask=$(linecol_2 "$line")
	prefix=$(linecol_3 "$line")

	if [[ $cask && $cask == 'cask' ]]; then
		brew install --cask $name
	else
		brew install $name
	fi

	if [[ $prefix ]]; then
		exp="export PATH=\"$prefix:\$PATH\""

		if ! grep -q "$exp" ~/.zshrc; then
			printf '\n%s\n' "$exp" >> ~/.zshrc
		fi
	fi
done < $vartree/brew.list

mark_init_done
info 'Installing homebrew packages ... OK'
