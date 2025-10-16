# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && command -v ghostty >/dev/null; then
	info 'Installing ghostty ... Skipped'
	exit
fi

sudo snap install --classic ghostty

sudo update-alternatives --install /usr/bin/x-terminal-emulator \
			 x-terminal-emulator $(command -v ghostty) 39

sudo update-alternatives --set x-terminal-emulator $(command -v ghostty)

sudo apt remove gnome-terminal

info 'Installing ghostty ... OK'
