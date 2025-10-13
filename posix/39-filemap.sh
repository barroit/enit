# SPDX-License-Identifier: GPL-3.0-or-later

trap 'rm -f .tmp-$$' EXIT

while IFS=$(printf '\t') read conf dir mode; do
	if need_skip_line "$conf"; then
		continue
	fi

	if [ -z "$dir" ] || [ "$dir" = - ]; then
		dir=$(col_2 $vartree/filemap $conf)
	fi

	dir=$(eval "printf '%s\n' \"$dir\"")
	src=$etctree/$conf
	dst="$dir/$(basename $conf)"

	ln_cmd='ln -sf'
	mkdir_cmd=mkdir

	if printf "%s\n" $mode | grep -q copy; then
		ln_cmd=cp
	fi

	if printf '%s\n' $mode | grep -q sudo; then
		ln_cmd="sudo $ln_cmd"
		mkdir_cmd="sudo $mkdir_cmd"
	fi

	eval "$mkdir_cmd -p \"$dir\"" || touch .tmp-$$
	eval "$ln_cmd $src \"$dst\"" || touch .tmp-$$

	if [ -f .tmp-$$ ]; then
		fmt="${RED}%s${RESET} -> %s\n"
	else
		fmt="${GREEN}%s${RESET} -> %s\n"
	fi

	printf "$fmt" "$dst" $src
	rm -f .tmp-$$

done <$vartree/filemap-$(os_id)

info 'Mapping files ... OK'
