#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

export stree=$(realpath $(dirname $0))
export ptree=$(dirname $(realpath $0))
export rtree=$(dirname $ptree)

. $ptree/lib39.sh

if [ -n "$1" ]; then
	name=$1

	if [ $(printf %.1s $name) = '+' ]; then
		force_marker=1
		name=${name#+}
	fi

	trap 'rm -f .script-$$' EXIT
	find $stree -name "[0-9][0-9]-$name*" >.script-$$

	if [ ! -s .script-$$ ]; then
		die "unknown script '$name'"
	fi

	if [ $(wc -l <.script-$$) -gt 1 ] &&
	   grep -qv '\.[0-9]\.sh' .script-$$; then
	   	lines=$(cat .script-$$ | xargs -n1 basename)
		lines=$(printf '\n  %s' $lines)

		die "ambiguous name '$name', can be:$lines"
	fi

	scripts=$(cat .script-$$)

	if [ $force_marker ]; then
		export force=$scripts
	fi

	rm .script-$$
fi

scripts=${scripts:-$(find $stree -name [0-9][0-9]-*.sh)}
scripts=$(printf '%s\n' $scripts | LC_ALL=C sort)

trap 'rm -f .tmp-$$' EXIT
printf 'Set working directory to %s\n' $HOME

for script in $scripts; do
	cd && $stree/run.sh $script && >.tmp-$$ || printf '%s\n' $? >.tmp-$$

	res=$(cat .tmp-$$)

	if [ "$res" = 39 ]; then
		die "$(basename $script) interrupts $(basename $0)"
	elif [ -n "$res" ]; then
		warn "$(basename $script) interrupted" || true
	fi
done
