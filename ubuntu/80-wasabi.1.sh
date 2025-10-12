# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && systemctl --user is-enabled --quiet wasabi.service; then
	info 'Setting up wasabi ... Skipped'
	exit
fi

mkdir -p .config/systemd/user
cd .config/systemd/user

cat <<EOF >wasabi.service
[Unit]
Wants=network-online.target
After=network-online.target

[Service]
ExecStart=$etctree/scripts/wasabi.sh mount
ExecStop=$etctree/scripts/wasabi.sh umount
RemainAfterExit=yes
Type=oneshot

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable --now wasabi.service

info 'Setting up wasabi ... OK'
