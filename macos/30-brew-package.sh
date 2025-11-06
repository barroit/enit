# SPDX-License-Identifier: GPL-3.0-or-later

brew update

trap 'rm -f .tmp-$$' EXIT

while read name search; do
	if need_skip_line "$name"; then
		continue
	fi

	# Brew's happy to fuck up our environment, isolate it.
	sh -c "brew install $name" 2>.tmp-$$ || true

	if [ -s .tmp-$$ ]; then
		warn "failed to install '$name'" || true
		continue
	fi

	if [ -n "$search" ]; then
		write_on_miss "export PATH=\"$search:\$PATH\"" .zprofile
	fi

done <$vartree/package.brew

ok 'Installing homebrew packages'
