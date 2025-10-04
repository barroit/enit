#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Configuring Bash PS1 ... Skipped'
	exit
fi

touch ~/.bashrc

ps1='\$ '
ps1="\[\e]0;\h: \w\a\]$ps1"

line="PS1='$ps1'"

if ! grep -Fq "$line" ~/.bashrc; then
	printf '\n%s\n' "$line" >> ~/.bashrc
fi

mark_init_done
info 'Configuring Bash PS1 ... OK'
