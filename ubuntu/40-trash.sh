# SPDX-License-Identifier: GPL-3.0-or-later

cd .local/share

if ! test_force_run && [ -L Trash ]; then
	info 'Fucking trash directory up ... Skipped'
	exit
fi

rm -rf Trash
ln -sf Trash Trash

info 'Fucking trash directory up ... OK'
