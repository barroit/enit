# SPDX-License-Identifier: GPL-3.0-or-later

find $bin -type l ! -exec test -e {} ';' -print | while read file; do
	printf "drop broken symlink ${RED}%s${RESET}\n" $file
	rm $file
done

pad=$(( $(printf '%s' $bin | wc -m) + 16 ))

while read name; do
	if need_skip_line "$name"; then
		continue
	fi

	src=$etctree/scripts/$name
	tar=$bin/$name

	ln -sf $src $tar
	printf "${GREEN}%-${pad}s${RESET} -> %s\n" $tar $src

done <$vartree/helper

ok 'Installing helper scripts'
