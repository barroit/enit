# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Configuring zsh history'

skip_inited

write_on_miss 'setopt HIST_IGNORE_DUPS' .zshrc

init_ok
