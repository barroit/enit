# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && [ -x .bun/bin/bun ]; then
	info 'Installing bun ... Skipped'
	exit
fi

curl -fsSL https://bun.sh/install | bash

info 'Installing bun ... OK'
