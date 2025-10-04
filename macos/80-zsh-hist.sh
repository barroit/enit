#!/bin/zsh
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Configuring Zsh history ... Skipped'
	exit
fi

line='setopt HIST_IGNORE_DUPS'

touch ~/.zshrc

if ! grep -Fq "$line" ~/.zshrc; then
	printf '\n%s\n' "$line" >> ~/.zshrc
fi

mark_init_done
info 'Configuring Zsh history ... OK'
