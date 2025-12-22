# SPDX-License-Identifier: GPL-3.0-or-later

find $bin -type l ! -exec test -e {} ';' -print | while read file; do
	printf "drop broken symlink ${RED}%s${RESET}\n" $file
	rm $file
done

pad=$(( $(printf '%s' $bin | wc -m) + 12 ))
prefix=$etctree/scripts

find $prefix -type f -exec realpath {} + | while read src; do
	if need_skip_line "$src"; then
		continue
	fi

	name=$(basename $src)
	dst=$bin/$name

	ln -sf $src $dst
	printf "${GREEN}%-${pad}s${RESET} -> %s\n" $dst $src
done

ok 'Installing helper scripts'
