# SPDX-License-Identifier: GPL-3.0-or-later
 
INFO_MESG='Suppressing no matching file found error of glob expansion'

skip_inited

write_on_miss 'unsetopt NOMATCH' .zshrc

init_ok
