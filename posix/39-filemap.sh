# SPDX-License-Identifier: GPL-3.0-or-later

set -e

trap 'rm -f .tmp-$$' EXIT

while read line; do
	if need_skip_line "$line"; then
		continue
	fi

	name=$(linecol_1 "$line")
	dst_dir=$(linecol_2 "$line")

	if [ -z "$dst_dir" ] || [ "$dst_dir" = - ]; then
		dst_dir=$(linecol_2 "$(grep $name $vartree/filemap)")
	fi

	dst_dir=$(eval printf '%s' "$dst_dir")
	mode=$(linecol_3 "$line")

	src=$etctree/$name
	dst=$dst_dir/$(basename $name)

	ln_cmd='ln -sf'
	mkdir_cmd=mkdir

	if printf "%s\n" $mode | grep -q copy; then
		ln_cmd=cp
	fi

	if printf '%s\n' $mode | grep -q sudo; then
		ln_cmd="sudo $ln_cmd"
		mkdir_cmd="sudo $mkdir_cmd"
	fi

	eval $mkdir_cmd -p "$dst_dir" || touch .tmp-$$
	eval $ln_cmd $src "$dst" || touch .tmp-$$

	if [ -f .tmp-$$ ]; then
		fmt="${RED}%s${RESET} -> %s\n"
	else
		fmt="${GREEN}%s${RESET} -> %s\n"
	fi

	printf "$fmt" "$dst" $src
	rm -f .tmp-$$

done <$vartree/filemap-$(os_id $0)

info 'Mapping files ... OK'
