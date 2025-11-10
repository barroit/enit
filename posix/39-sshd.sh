# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Configuring sshd'

skip_inited

cat <<EOF | sudo tee /etc/ssh/sshd_config.d/39-auth.conf >/dev/null
# $(wrote)
UsePAM yes
KbdInteractiveAuthentication no
PasswordAuthentication no
EOF

cat <<EOF | sudo tee /etc/ssh/sshd_config.d/39-env.conf >/dev/null
# $(wrote)
AcceptEnv SSH_AUTH_SOCK
EOF

cat <<EOF | sudo tee /etc/ssh/sshd_config.d/39-auth-sock.conf >/dev/null
# $(wrote)
StreamLocalBindUnlink yes
EOF

init_ok
