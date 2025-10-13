# SPDX-License-Identifier: GPL-3.0-or-later

touch .zshrc
touch .zsh_prompt

wrote_on_miss_sh "PS1='%# '" .zsh_prompt

wrote_on_miss_sh "$(cat <<EOF | tr -d '\t' | tr '\n' ' '
precmd()
{
	git rev-parse --is-inside-work-tree >/dev/null 2>&1 &&
	print -nP "\\033]0;%m+%L: %~ (\$(git branch --show-current))\a" ||
	print -nP '\\033]0;%m+%L: %~\a';
}
EOF
)" .zsh_prompt

wrote_on_miss_sh '[ -f $HOME/.zsh_prompt ] && . $HOME/.zsh_prompt' .zshrc

info 'Configuring Z shell prompt ... OK'
