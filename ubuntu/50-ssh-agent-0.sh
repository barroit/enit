# SPDX-License-Identifier: GPL-3.0-or-later

mkdir -p .config/autostart
cd .config/autostart

cp /etc/xdg/autostart/gnome-keyring-ssh.desktop ./

printf 'Hidden=true\n' >>gnome-keyring-ssh.desktop

info 'Hidding gnome-keyring-ssh ... OK'
