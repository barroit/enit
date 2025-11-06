# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Disable GUI alive checking'

skip_inited

gsettings set org.gnome.mutter check-alive-timeout 0

init_ok
