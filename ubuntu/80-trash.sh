# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Configuring trash can ... Skipped'
	exit
fi

cat <<EOF > ~/.config/systemd/user/trash.service
[Unit]
After=default.target

[Service]
ExecStart=rm -rf %h/.local/share/Trash
Type=oneshot

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable ~/.config/systemd/user/trash.service

mark_init_done
info 'Configuring trash can ... OK'
