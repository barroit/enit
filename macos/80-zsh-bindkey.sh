# SPDX-License-Identifier: GPL-3.0-or-later

touch .zsh_bindkey
touch .zshrc

while read line; do
	if need_skip_line "$line"; then
		continue
	fi

	wrote_on_miss_sh "$line" .zsh_bindkey

done <$vartree/bindkey.zsh

wrote_on_miss_sh 'test -f $HOME/.zsh_bindkey && . $HOME/.zsh_bindkey' .zshrc

info 'Adding Z shell bindkey ... OK'
