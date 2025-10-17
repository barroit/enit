# SPDX-License-Identifier: GPL-3.0-or-later
# Don't use Homebrew version, it lacks FUSE fs support.

if ! test_force_run && [ "$(command -v rclone)" = /usr/local/bin/rclone ]; then
	info 'Installing rclone ... Skipped'
	exit
fi

curl https://rclone.org/install.sh | sudo bash

info 'Installing rclone ... OK'
