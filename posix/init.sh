#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

export stree=$(realpath $(dirname $0))
export ptree=$(dirname $(realpath $0))
export rtree=$(dirname $ptree)
export dotforce=$stree/.force-$$

cd $stree

. $ptree/lib39.sh

trap 'rm -f .tmp-$$ $dotforce \
      $stree/.find-$$ $stree/.script-$$ $stree/.task-$$' EXIT

while [ $# -gt 0 ]; do
	argcpy=$1
	name=${1#+}

	prefix=
	suffix=

	if ! expr "$name" : '[0-9][0-9]-.*' >/dev/null &&
	   ! expr "$name" : '\[0-9\]\[0-9\]-.*' >/dev/null; then
		prefix=[0-9][0-9]-
		name=$prefix$name
	fi

	if ! expr "$name" : '.*\*.*' >/dev/null &&
	   ! expr "$name" : '.*\.sh' >/dev/null; then
		suffix=*
		name=$name$suffix
	fi

	find $stree -name "$name" >.find-$$

	if [ $(wc -l <.find-$$) -gt 1 ] && [ -n "$suffix" ]; then
		sed 's/\.[0-9]\.sh$//' .find-$$ >.tmp-$$

		if grep -q '\.sh$' .tmp-$$ ||
		   grep -xqFv $(head -n1 .tmp-$$) .tmp-$$; then
			scripts=$(cat .find-$$ | xargs -n1 basename)
			scripts=$(printf '\n  %s' $scripts)

			die "ambiguous name '$argcpy', can be:$scripts"
		fi
	fi

	if [ ! -s .find-$$ ]; then
		die "no matching script found for '$argcpy'"
	fi

	dup=/dev/null

	if [ "$(printf %.1s "$argcpy")" = + ]; then
		dup=$dotforce
	fi

	cat .find-$$ | tee -a .script-$$ >>$dup
	shift
done

if [ ! -s .script-$$ ]; then
	find $stree -name '[0-9][0-9]-*.sh' >.script-$$
fi

LC_ALL=C sort <.script-$$ >.task-$$

printf 'Set working directory to %s\n' $HOME

while read script; do
	cd
	>.tmp-$$

	$stree/run.sh $script || printf '%s\n' $? >.tmp-$$

	if grep -xqF 39 .tmp-$$; then
		die "$(basename $script) interrupts $(basename $0)"
	elif [ -s .tmp-$$ ]; then
		warn "$(basename $script) interrupted" || true
	fi

done <.task-$$
