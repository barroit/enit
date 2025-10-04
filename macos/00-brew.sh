#!/bin/zsh
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Installing Homebrew ... Skipped'
	exit
fi

url=https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

/bin/bash -c "$(curl -fsSL $url)"

if [[ $? -ne 0 ]]; then
	exit 128
fi

mark_init_done
info 'Installing Homebrew ... OK'
