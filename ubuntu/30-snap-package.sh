# SPDX-License-Identifier: GPL-3.0-or-later

trap 'rm -f .local-$$ .install-$$ .classic-$$' EXIT

snap list | awk 'NR == 1 { next } { print $1 }' >.local-$$
>.install-$$
>.classic-$$

while read name classic; do
	if need_skip_line "$name" || grep -xqF $name .local-$$; then
		continue
	fi

	printf '%s\n' $name >>.${classic:-install}-$$

done <$vartree/package.snap

while read name; do
	sudo snap install $name
done <.install-$$

while read name; do
	sudo snap install --classic $name
done <.classic-$$

ok 'Installing snap packages'
