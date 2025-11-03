# SPDX-License-Identifier: GPL-3.0-or-later
#
# on Ubuntu 24.04:
#
#	$ echo $SSH_AUTH_SOCK
#	$ /run/user/1000/keyring/ssh
#
# GNOME Keyring is fucking ssh agent socket up. Kill this GUI dumbass, we only
# use plaintext prompt.

mkdir -p .config/autostart
cd .config/autostart

cp /etc/xdg/autostart/gnome-keyring-ssh.desktop ./

printf 'Hidden=true\n' >>gnome-keyring-ssh.desktop

cd
write_on_miss 'export GPG_TTY=$(tty)' .bashrc

gpg-connect-agent reloadagent /bye

note 'restart session for changes to take effect'
info 'Setting primary ssh agent to gpg-agent ... OK'
