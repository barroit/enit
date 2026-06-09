# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Configuring rclone'

! test_force_run && [ -s .config/rclone/rclone.conf ] && skip

mkdir -p .config/rclone
cd .config/rclone

trap 'rm -f .tmp-$$' EXIT
gpg --yes -o rclone.conf -d $HOME/conf_rclone.gpg || touch .tmp-$$

if [ -f .tmp-$$ ]; then
	die "failed to import $HOME/conf_rclone.gpg"
fi

ok
