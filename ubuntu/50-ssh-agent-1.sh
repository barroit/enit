# SPDX-License-Identifier: GPL-3.0-or-later

systemctl --user stop gpg-agent-ssh.socket
systemctl --user mask gpg-agent-ssh.socket
rm -f /run/user/1000/gnupg/S.gpg-agent.ssh

info 'Masking gpg-agent-ssh.socket ... OK'
