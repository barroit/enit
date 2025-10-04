#!/bin/zsh
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Configuring ssh server ... Skipped'
	exit
fi

sudo systemsetup -setremotelogin on

cd ~/.ssh

ssh-keygen -y -f id_dev_macos > authorized_keys

cat <<EOF | sudo tee /etc/ssh/sshd_config.d/39-auth.conf
UsePAM yes
KbdInteractiveAuthentication no
PasswordAuthentication no
EOF

sudo launchctl kickstart -k system/com.openssh.sshd

mark_init_done
info 'Configuring ssh server ... OK'
