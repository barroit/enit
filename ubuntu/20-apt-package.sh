# SPDX-License-Identifier: GPL-3.0-or-later

set -e

sudo apt update

trap 'rm -f .package.tmp' EXIT

while read line; do
	if need_skip_line "$line"; then
		continue
	fi

	name=$(linecol_1 "$line")
	type=$(linecol_2 "$line")

	case $type in
	'd')
		if test_vm; then
			continue
		fi
	esac

	printf '%s ' $name >>.package.tmp
done <$vartree/package.apt

sudo apt install -y $(cat .package.tmp)

info 'Installing apt packages ... OK'
