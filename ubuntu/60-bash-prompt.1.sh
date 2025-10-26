# SPDX-License-Identifier: GPL-3.0-or-later

touch .bashrc
touch .bash_prompt

write_on_miss_sh "$(cat <<EOF | oneline
precmd()
{
	PS1=\$(git rev-parse --is-inside-work-tree >/dev/null 2>&1 &&
	       printf '\[\e]0;\h+\$SHLVL: \w (%s%s)\a\]\\$ ' 
		      \$(branch_now) "\$(branch_stat_dumb)" ||
	       printf '\[\e]0;\h+\$SHLVL: \w\a\]\\$ ');
}
EOF
)" .bash_prompt

write_on_miss_sh 'PROMPT_COMMAND=precmd' .bash_prompt

write_on_miss_sh '[ -f $HOME/.bash_prompt ] && . $HOME/.bash_prompt' .bashrc

info 'Configuring Bash prompt ... OK'
