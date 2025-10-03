#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

stree=$(realpath $(dirname $0))
ptree=$(dirname $(realpath $0))

. $ptree/lib39.sh

if [ -n "$1" ]; then
	name=$1

	if [ $(printf %.1s $name) = '+' ]; then
		force=1
		name=${name#+}
	fi

	case $name in
	[0-9][0-9]-*)
		scripts=$(find $stree -name $name | sort)
		;;
	*)
		scripts=$(find $stree -name [0-9][0-9]-$name*.sh | sort)
		;;
	esac

	if [ -z "$scripts" ]; then
		die "unknown script '$name'"
	fi

	if [ $(printf '%s\n' $scripts | wc -l) -ne 1 ]; then
		lines=$(printf '%s\n' $scripts | xargs -n1 basename)
		lines=$(printf '\n  %s' $lines)

		die "ambiguous script '$name'; could be:$lines"
	fi

	if [ $force ]; then
		export force=$scripts
	fi
fi

scripts=${scripts:-$(find $stree -name [0-9][0-9]-*.sh | sort)}

for script in $scripts; do
	$stree/exec.sh $script

	if [ $? -ne 0 ]; then
		warn "$(basename $script) interrupted"
	fi
done
