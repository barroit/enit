# SPDX-License-Identifier: GPL-3.0-or-later

brew update
brew upgrade

trap 'rm -f .local-$$ .update-$$ .skip-$$' EXIT

brew list --formula >.local-$$
brew list --cask >>.local-$$

brew outdated --quiet >.update-$$
printf 'dummy39\n' >>.update-$$

grep -xvFf .update-$$ .local-$$ >.skip-$$

while read name bin; do
	if need_skip_line "$name"; then
		continue
	fi

	if grep -qF $name .skip-$$; then
		continue
	fi

	# Brew's happy to fuck up our environment, isolate it.
	sh -c "brew install $name" 2>.tmp-$$ || true

	if [ -s .tmp-$$ ]; then
		cat .tmp-$$ >&2
		continue
	fi

	if [ -n "$bin" ]; then
		write_on_miss "export PATH=\"$bin:\$PATH\"" .zprofile
	fi

done <$vartree/package.brew

ok 'Installing homebrew packages'
