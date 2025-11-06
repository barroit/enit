# SPDX-License-Identifier: GPL-3.0-or-later

while read line; do
	if need_skip_line "$line"; then
		continue
	fi

	write_on_miss "$line" .zsh_bindkey

done <$vartree/bindkey.zsh

write_on_miss '[ -f $HOME/.zsh_bindkey ] && . $HOME/.zsh_bindkey' .zshrc

ok 'Adding zsh bindkey'
