# SPDX-License-Identifier: GPL-3.0-or-later
#
# https://rclone.org/commands/rclone_mount/#rclone-as-unix-mount-helper

sudo ln -sf /usr/bin/rclone /sbin/mount.rclone

mkdir -p .config/systemd/user
cd .config/systemd/user

while read remote local; do
	local=$(eval printf %s $local)
	dotmnt=$(printf %s.mount ${local#/} | tr / -)

	mkdir -p $local

	cat <<-EOF >$dotmnt
	[Unit]
	Wants=network-online.target
	After=network-online.target

	[Mount]
	Type=rclone
	What=$remote
	Where=$local
	Options=vfs-cache-mode=full,vfs-links

	[Install]
	WantedBy=default.target
	EOF

	if ! systemctl --user is-enabled --quiet $dotmnt; then
		systemctl --user enable --now $dotmnt

	else
		systemctl --user daemon-reload
		systemctl --user restart $dotmnt
	fi

	info "started $dotmnt"

done <$vartree/wasabi

ok 'Enabling wasabi mount points'
