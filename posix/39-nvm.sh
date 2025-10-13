# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && [ -x .nvm/nvm.sh ]; then
	info 'Installing nvm ... Skipped'
	exit
fi

trap 'rm -f .tmp-$$' EXIT
curl -sL \
     -H 'Accept: application/vnd.github+json' \
     -H 'X-GitHub-Api-Version: 2022-11-28' \
     'https://api.github.com/repos/nvm-sh/nvm/releases?per_page=1' >.tmp-$$

tag=$(jq -r '.[0].name' .tmp-$$)

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$tag/install.sh | bash

info 'Installing nvm ... OK'
