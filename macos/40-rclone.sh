# SPDX-License-Identifier: GPL-3.0-or-later
#
# Don't use Homebrew version, it lacks FUSE fs support.

INFO_MESG='Installing rclone'

! test_force_run && [ "$(command -v rclone)" = /usr/local/bin/rclone ] && skip

sudo -v && curl https://rclone.org/install.sh | sudo bash

ok
