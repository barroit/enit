#!/bin/zsh
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Configuring Zsh PS1 ... Skipped'
	exit
fi

touch ~/.zshrc

line="PS1='%# '"

if ! grep -Fxq "$line" ~/.zshrc; then
	printf '\n%s\n' "$line" >> ~/.zshrc
fi

if ! grep -Fxq 'precmd()' ~/.zshrc; then
	cat <<'EOF' >> ~/.zshrc

precmd()
{
	print -Pn '\e]0;%m: %~\a'
}
EOF
fi

mark_init_done
info 'Configuring Zsh PS1 ... OK'
