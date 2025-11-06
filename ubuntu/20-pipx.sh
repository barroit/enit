# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Installing pipx'

skip_installed pipx

sudo apt install -y pipx

pipx ensurepath

ok
