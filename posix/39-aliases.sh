# SPDX-License-Identifier: GPL-3.0-or-later

touch ${dotsh}rc
touch ${dotsh}_aliases

cat $vartree/aliases $(find $vartree -name "aliases.$(os_id)") | \
while read name command; do
	if need_skip_line "$name"; then
		continue
	fi

	write_on_miss_sh "alias $name='$command'" ${dotsh}_aliases
done

write_on_miss_sh "[ -f \$HOME/${dotsh}_aliases ] && . \$HOME/${dotsh}_aliases" \
		 ${dotsh}rc

info "Aliasing ${dotsh#.} commands ... OK"
