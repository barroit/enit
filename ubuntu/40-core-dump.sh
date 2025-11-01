# SPDX-License-Identifier: GPL-3.0-or-later

write_on_miss 'ulimit -c unlimited' .bashrc

if systemctl status apport.service >/dev/null 2>&1; then
	sudo systemctl stop apport.service
	sudo systemctl disable apport.service
fi

cat <<EOF | sudo tee /etc/sysctl.d/39-core-dump.conf >/dev/null
kernel.core_uses_pid = 0
kernel.core_pattern = core.%e
EOF

sudo service procps reload

info 'Enabling core dump ... OK'
