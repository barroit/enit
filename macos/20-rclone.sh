# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Installing rclone ... Skipped'
	exit
fi

curl https://rclone.org/install.sh | sudo bash

mark_init_done
info 'Installing rclone ... OK'
