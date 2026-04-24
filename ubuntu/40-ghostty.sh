# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Installing ghostty'

skip_installed ghostty

sudo update-alternatives --install /usr/bin/x-terminal-emulator \
			 x-terminal-emulator $(command -v ghostty) 39

sudo update-alternatives --set x-terminal-emulator $(command -v ghostty)

ok
