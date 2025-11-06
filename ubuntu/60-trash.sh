# SPDX-License-Identifier: GPL-3.0-or-later
# FIXME: broken

cd .local/share

if ! test_force_run && [ -L Trash ]; then
	info 'Fucking trash directory up ... Skipped'
	exit
fi

rm -rf Trash
ln -sf Trash Trash

ok 'Fucking trash directory up'
