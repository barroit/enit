# SPDX-License-Identifier: GPL-3.0-or-later

trap 'rm -f .err-$$' EXIT

cd $etctree

while IFS=$TAB read name outdir mode; do
	if need_skip_line "$name"; then
		continue
	fi

	if [ -z "$outdir" ] || [ "$outdir" = - ]; then
		outdir=$(grep -F "$name" $vartree/filemap | cut -f2)
	fi

	outdir=$(eval "printf %s \"$outdir\"")
	indir=$(dirname "$name")

	ln='ln -sf'
	mkdir=mkdir

	if printf %s "$mode" | sed 's/,/\n/' | grep -xqF copy; then
		ln=cp
	fi

	if printf %s "$mode" | sed 's/,/\n/' | grep -xqF sudo; then
		sudo=sudo
	fi

	eval "$sudo $mkdir -p '$outdir'" 2>.err-$$ &&
	eval "$sudo $ln $PWD/$name '$outdir'" 2>.err-$$ || true

	if [ -s .err-$$ ]; then
		fmt="%s $BOLD$RED==>$RESET %s\n"
		cat .err-$$ >&2
	else
		fmt="%s $BOLD$GREEN==>$RESET %s\n"
	fi

	printf '%s\n' $name | \
	xargs -I{} sh -c "printf '$fmt' \"$outdir/\$(basename {})\" $PWD/{}"

done <$vartree/filemap-$(os_id)

ok 'Mapping files'
