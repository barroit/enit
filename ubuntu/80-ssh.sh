#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done || ! test_vm; then
	info 'Configuring ssh server ... Skipped'
	exit
fi

cd ~/.ssh

ssh-keygen -y -f id_lvm_noble > authorized_keys

cat <<EOF | sudo tee /etc/ssh/sshd_config.d/39-auth.conf
PasswordAuthentication no
EOF

sudo systemctl restart ssh.service

mark_init_done
info 'Configuring ssh server ... OK'
