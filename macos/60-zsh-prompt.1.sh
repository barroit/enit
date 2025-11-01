# SPDX-License-Identifier: GPL-3.0-or-later

write_on_miss "PS1='%# '" .zsh_prompt

write_on_miss "$(cat <<EOF | oneline
precmd()
{
	git rev-parse --is-inside-work-tree >/dev/null 2>&1 &&
	print -nP "\\033]0;%m+%L: %~ (\$(branch_now)\$(branch_stat_dumb))\a" ||
	print -nP '\\033]0;%m+%L: %~\a';
}
EOF
)" .zsh_prompt

write_on_miss '[ -f $HOME/.zsh_prompt ] && . $HOME/.zsh_prompt' .zshrc

info 'Configuring Z shell prompt ... OK'
