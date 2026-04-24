# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Disabling other ssh agents'

skip_inited

mkdir -p .config/autostart
cd .config/autostart

while read name; do
	systemctl --user disable --now $name
	systemctl --user mask $name
done <<EOF
	gcr-ssh-agent.socket
	gcr-ssh-agent.service
	ssh-agent.socket
EOF

init_ok
