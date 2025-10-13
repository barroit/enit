# SPDX-License-Identifier: GPL-3.0-or-later

touch .zshrc
touch .zsh_bindkey

while read line; do
	if need_skip_line "$line"; then
		continue
	fi

	wrote_on_miss_sh "$line" .zsh_bindkey

done <$vartree/bindkey.zsh

wrote_on_miss_sh '[ -f $HOME/.zsh_bindkey ] && . $HOME/.zsh_bindkey' .zshrc

info 'Adding Z shell bindkey ... OK'
