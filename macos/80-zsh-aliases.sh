# SPDX-License-Identifier: GPL-3.0-or-later

touch .zshrc
touch .zsh_aliases

while read name command; do
	if need_skip_line "$name"; then
		continue
	fi

	wrote_on_miss_sh "alias $name='$command'" .zsh_aliases

done <$vartree/aliases

wrote_on_miss_sh 'test -f $HOME/.zsh_aliases && . $HOME/.zsh_aliases' .zshrc

info 'Aliasing commands ... OK'
