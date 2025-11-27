# SPDX-License-Identifier: GPL-3.0-or-later

trap 'rm -f .err-$$' EXIT

cd $etctree

read_config_patched filemap | while IFS=$TAB read name outdir mode; do
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

	indir=$(printf '%s' $PWD/$indir | sed "s|$HOME|\$HOME|")
	outdir=$(printf '%s' $outdir | sed "s|$HOME|\$HOME|")

	printf '%s\n' $name | xargs -L1 basename | \
	xargs -I{} sh -c "printf '$fmt' '$outdir/{}' '$indir/{}'"

done

ok 'Mapping files'
