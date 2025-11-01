# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Configuring sshd ... Skipped'
	exit
fi

mkdir -p .ssh
cd .ssh

write_on_miss "$(ssh-keygen -y -f $sshd_key)" authorized_keys

cat <<EOF | sudo tee /etc/ssh/sshd_config.d/39-auth.conf >/dev/null
# $(wrote)
UsePAM yes
KbdInteractiveAuthentication no
PasswordAuthentication no
EOF

mark_init_done
info 'Configuring sshd ... OK'
