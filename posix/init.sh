#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

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

	if [ $force_marker ]; then
		export force=$scripts
	fi
fi

scripts=${scripts:-$(find $stree -name [0-9][0-9]-*.sh | sort)}

for script in $scripts; do
	$stree/run.sh $script
	res=$?

	if [ $res -eq 39 ]; then
		die "$(basename $script) interrupts $(basename $0)"
	elif [ $res -ne 0 ]; then
		warn "$(basename $script) interrupted"
	fi
done
