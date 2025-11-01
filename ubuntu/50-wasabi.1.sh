# SPDX-License-Identifier: GPL-3.0-or-later
# https://rclone.org/commands/rclone_mount/#rclone-as-unix-mount-helper

rclone --version >/dev/null
sudo ln -sf /usr/bin/rclone /sbin/mount.rclone

mkdir -p .config/systemd/user
cd .config/systemd/user

while read remote local; do
	local=$(eval printf %s $local)
	dotmount=$(printf %s.mount ${local#/} | tr / -)

	mkdir -p $local

	cat <<-EOF >$dotmount
	[Unit]
	Requires=network-online.target
	After=network-online.target

	[Mount]
	Type=rclone
	What=$remote
	Where=$local
	Options=vfs-cache-mode=full

	[Install]
	WantedBy=default.target
	EOF

	if ! systemctl --user is-enabled --quiet $dotmount; then
		systemctl --user enable --now $dotmount

	else
		systemctl --user daemon-reload
		systemctl --user restart $dotmount
	fi

done <$vartree/wasabi

info 'Setting up wasabi ... OK'
