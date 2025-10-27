# SPDX-License-Identifier: GPL-3.0-or-later

trap 'rm -f .tmp-$$' EXIT

while read name; do
	if need_skip_line "$name"; then
		continue
	fi

	printf '%s ' $name >>.tmp-$$

done <$vartree/package.flatpak

flatpak install -y flathub $(cat .tmp-$$)

info 'Installing flatpak packages ... OK'
