# SPDX-License-Identifier: GPL-3.0-or-later

trap 'rm -f .tmp-$$' EXIT
pipx list --short >.tmp-$$

while read line; do
	if need_skip_line "$line"; then
		continue
	fi

	if grep -qi $line .tmp-$$; then
		continue
	fi

	pipx install $line

done <$vartree/package.pip

ok 'Installing pipx packages'
