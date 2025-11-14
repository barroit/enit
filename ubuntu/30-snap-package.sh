# SPDX-License-Identifier: GPL-3.0-or-later

trap 'rm -f .local-$$ .install-$$ .classic-$$' EXIT

snap list | awk 'NR == 1 { next } { print $1 }' >.local-$$

while read name classic; do
	if need_skip_line "$name" || grep -xqF $name .local-$$; then
		continue
	fi

	printf '%s\n' $name >>.${classic:-install}-$$

done <$vartree/package.snap

if [ -s .install-$$ ]; then
	sudo snap install $(cat .install-$$)
fi

if [ -s .classic-$$ ]; then
	sudo snap install --classic $(cat .classic-$$)
fi

ok 'Installing snap packages'
