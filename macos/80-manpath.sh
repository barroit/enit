# SPDX-License-Identifier: GPL-3.0-or-later

touch .zprofile

wrote_on_miss_sh 'export MANPATH="/$HOME/.local/share/man:$MANPATH"' .zprofile

info 'Updating MANPATH ... OK'
