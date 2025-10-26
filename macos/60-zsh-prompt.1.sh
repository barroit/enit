# SPDX-License-Identifier: GPL-3.0-or-later

touch .zshrc
touch .zsh_prompt

write_on_miss_sh "PS1='%# '" .zsh_prompt

write_on_miss_sh "$(cat <<EOF | oneline
precmd()
{
	git rev-parse --is-inside-work-tree >/dev/null 2>&1 &&
	print -nP "\\033]0;%m+%L: %~ (\$(branch_now))\a" ||
	print -nP '\\033]0;%m+%L: %~\a';
}
EOF
)" .zsh_prompt

write_on_miss_sh '[ -f $HOME/.zsh_prompt ] && . $HOME/.zsh_prompt' .zshrc

info 'Configuring Z shell prompt ... OK'
