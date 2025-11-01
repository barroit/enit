# SPDX-License-Identifier: GPL-3.0-or-later

set +e

brew update

while read name search; do
	if need_skip_line "$name"; then
		continue
	fi

	sh -c "brew install $name"

	if [ $? -ne 0 ]; then
		warn "failed to install '$name'"
		continue
	fi

	if [ -n "$search" ]; then
		write_on_miss_sh "export PATH=\"$search:\$PATH\"" .zprofile
	fi

done <$vartree/package.brew

info 'Installing Homebrew packages ... OK'
