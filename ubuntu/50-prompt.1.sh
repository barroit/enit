# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Configuring bash prompt'

skip_inited

cat <<'EOF' | oneline | write_on_miss .bash_prompt
precmd()
{
	PS1=$(git rev-parse --is-inside-work-tree >/dev/null 2>&1 &&
	      printf '\[\e]0;\h+$SHLVL: \w (%s%s)\a\]\$ ' 
		     $(branch_now) "$(branch_stat_dumb)" ||
	      printf '\[\e]0;\h+$SHLVL: \w\a\]\$ ');
}
EOF

write_on_miss 'PROMPT_COMMAND=precmd' .bash_prompt

write_on_miss '[ -f $HOME/.bash_prompt ] && . $HOME/.bash_prompt' .bashrc

init_ok
