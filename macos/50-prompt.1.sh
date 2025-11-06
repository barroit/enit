# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Configuring zsh prompt'

skip_inited

write_on_miss "PS1='%# '" .zsh_prompt

cat <<'EOF' | oneline | write_on_miss .zsh_prompt
precmd()
{
	git rev-parse --is-inside-work-tree >/dev/null 2>&1 &&
	print -nP "\033]0;%m+%L: %~ ($(branch_now)$(branch_stat_dumb))\a" ||
	print -nP '\033]0;%m+%L: %~\a';
}
EOF

write_on_miss '[ -f $HOME/.zsh_prompt ] && . $HOME/.zsh_prompt' .zshrc

init_ok
