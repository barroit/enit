# SPDX-License-Identifier: GPL-3.0-or-later
#
# on Ubuntu 24.04:
#
#	$ echo $SSH_AUTH_SOCK
#	$ /run/user/1000/keyring/ssh
#
# GNOME Keyring is fucking ssh agent socket up. Kill this GUI dumbass, we only
# use plaintext prompt. And:
#
#	$ echo $SSH_AUTH_SOCK
#	$ /run/user/1000/gnupg/S.gpg-agent.ssh
#
# GnuPG makes socket more messy. Kill it also.

systemctl --user restart ssh-agent.service

note 'restart session for changes to take effect'
info 'Making openssh_agent primary ... OK'
