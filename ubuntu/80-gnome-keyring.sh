# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Disabling ssh component of gnome keyring'

! test_force_run && [ -s .config/autostart/gnome-keyring-ssh.desktop ] && skip

mkdir -p .config/autostart
cd .config/autostart

cp /etc/xdg/autostart/gnome-keyring-ssh.desktop .

printf 'Hidden=true\n' >>gnome-keyring-ssh.desktop

note 'restart session to make changes take effect'

ok
