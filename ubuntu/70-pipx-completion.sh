# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Adding pipx autocompletion to bash'

skip_inited

write_on_miss 'eval "$(register-python-argcomplete pipx)"' .bashrc

init_ok
