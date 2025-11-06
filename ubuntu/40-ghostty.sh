# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Installing ghostty'

skip_installed ghostty

sudo snap install --classic ghostty

sudo update-alternatives --install /usr/bin/x-terminal-emulator \
			 x-terminal-emulator $(command -v ghostty) 39

sudo update-alternatives --set x-terminal-emulator $(command -v ghostty)

sudo apt remove gnome-terminal

ok
