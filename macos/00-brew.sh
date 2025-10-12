# SPDX-License-Identifier: GPL-3.0-or-later

url=https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

if ! test_force_run && command -v brew >/dev/null ; then
	info 'Installing Homebrew ... Skipped'
	exit
fi

/bin/bash -c "$(curl -fsSL $url)"

info 'Installing Homebrew ... OK'
