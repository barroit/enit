# SPDX-License-Identifier: GPL-3.0-or-later

sudo systemsetup -setremotelogin on
sudo launchctl kickstart -k system/com.openssh.sshd

ok 'Restarting sshd'
