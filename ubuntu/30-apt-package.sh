# SPDX-License-Identifier: GPL-3.0-or-later

sudo apt update

trap 'rm -f .tmp-$$' EXIT

while read name; do
	if need_skip_line "$name"; then
		continue
	fi

	printf '%s ' $name >>.tmp-$$

done <$vartree/package.apt

sudo apt install -y $(cat .tmp-$$)

ok 'Installing apt packages'
