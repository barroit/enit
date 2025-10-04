#!/bin/zsh
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Configuring Zsh auto completion ... Skipped'
	exit
fi

read -d '' lines <<EOF
autoload -Uz compinit
compinit
EOF

if ! grep -Fxq "$lines" ~/.zshrc; then
	printf '\n%s\n' "$lines" >> ~/.zshrc
fi

mark_init_done
info 'Configuring Zsh auto completion ... OK'
