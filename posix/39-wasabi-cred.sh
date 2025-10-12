# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && [ -f .config/rclone/rclone.conf ]; then
	info 'Dumping wasabi credential ... Skipped'
	exit
fi

require_vault

mkdir -p .config/rclone
cd .config/rclone

trap 'rm -f .tmp-$$' EXIT
gpg --yes -o rclone.conf -d $vault/rclone.conf.gpg || touch .tmp-$$

if [ -f .tmp-$$ ]; then
	die "failed to import $vault/rclone.conf.gpg"
fi

info 'Dumping wasabi credential ... OK'
