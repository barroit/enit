# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Configuring sshd ... Skipped'
	exit
fi

mkdir -p $HOME/.ssh
cd $HOME/.ssh

cat <<-EOF >authorized_keys
	# $(on_date), $script_id wrote:
	$(ssh-keygen -y -f $sshd_key)
EOF

cat <<-EOF | sudo tee /etc/ssh/sshd_config.d/39-auth.conf >/dev/null
	# $(on_date), $script_id wrote:
	UsePAM yes
	KbdInteractiveAuthentication no
	PasswordAuthentication no
EOF

mark_init_done
info 'Configuring sshd ... OK'
