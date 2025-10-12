# SPDX-License-Identifier: GPL-3.0-or-later

set +e

brew update
touch .zshrc

while read line; do
	if need_skip_line "$line"; then
		continue
	fi

	name=$(linecol_1 "$line")
	search=$(linecol_2 "$line")

	brew install $name

	if [ $? -ne 0 ]; then
		warn "failed to install '$name'"
		continue
	fi

	if [ -n "$search" ]; then
		pattern="export PATH=\"$search:\$PATH\""

		if ! grep -q "$pattern" .zshrc; then
			cat <<-EOF >>.zshrc

				# $(on_date), $script_id wrote:
				$pattern
			EOF
		fi
	fi

done < $vartree/package.brew

info 'Installing Homebrew packages ... OK'
