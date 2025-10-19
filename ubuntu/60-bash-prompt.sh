# SPDX-License-Identifier: GPL-3.0-or-later

touch .bashrc
touch .bash_prompt

wrote_on_miss_sh "$(cat <<EOF | tr -d '\t' | tr -s '\n' ' '
precmd()
{
	PS1=\$(git rev-parse --is-inside-work-tree >/dev/null 2>&1 &&
	       printf '\[\e]0;\h+\$SHLVL: \w (%s)\a\]\\$ ' \
		      \$(git rev-parse --abbrev-ref HEAD) ||
	       printf '\[\e]0;\h+\$SHLVL: \w\a\]\\$ ');
}
EOF
)" .bash_prompt

wrote_on_miss_sh 'PROMPT_COMMAND=precmd' .bash_prompt

wrote_on_miss_sh '[ -f $HOME/.bash_prompt ] && . $HOME/.bash_prompt' .bashrc

info 'Configuring Bash prompt ... OK'
