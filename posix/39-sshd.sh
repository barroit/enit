# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Configuring sshd'

! test_force_run && [ -s /etc/ssh/sshd_config.d/39-auth.conf ] && skip

cat <<EOF | sudo tee /etc/ssh/sshd_config.d/39-auth.conf >/dev/null
# $(wrote)
UsePAM yes
KbdInteractiveAuthentication no
PasswordAuthentication no
EOF

init_ok
