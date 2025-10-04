#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

if ! test_force_run && test_init_done; then
	info 'Mapping files ... Skipped'
	exit
fi

while read line; do
	if need_skip_line "$line"; then
		continue
	fi

	name=$(linecol_1 "$line")
	dst_dir=$(linecol_2 "$line")

	if [ -z "$dst_dir" ] || [ "$dst_dir" = - ]; then
		dst_dir=$(linecol_2 "$(grep $name $vartree/filemap)")
	fi

	if [ -z "$dst_dir" ]; then
		warn "skipping '$name' as you fucked '$vartree/filemap' up"
		continue
	fi

	dst_dir=$(eval "printf '%s\n' \"$dst_dir\"")
	mode=$(linecol_3 "$line")

	src=$etctree/$name
	dst=$dst_dir/$(basename $name)
	cmd='ln -sf'

	if printf "%s\n" $mode | grep -q copy; then
		cmd=cp
	fi

	if printf '%s\n' $mode | grep -q sudo; then
		cmd="sudo $cmd"
	fi

	mkdir -p "$dst_dir"
	eval "$cmd $src \"$dst\""

	if [ $? -eq 1 ]; then
		fmt="${CYAN}%-25s${RESET} -> ${RED}%s${RESET}\n"
	else
		fmt="${CYAN}%-25s${RESET} -> ${GREEN}%s${RESET}\n"
	fi

	printf "$fmt" $name "$dst"

done <$vartree/filemap-$(os_id)

mark_init_done
info 'Mapping files ... OK'
