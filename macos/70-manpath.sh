# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Updating MANPATH'

skip_inited

write_on_miss "export MANPATH=\"$HOME/.local/share/man:\$MANPATH\"" .zprofile

init_ok
