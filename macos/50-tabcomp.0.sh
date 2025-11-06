# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Enabling zsh completion'

skip_inited

write_on_miss 'autoload -Uz compinit && compinit' .zshrc
write_on_miss 'autoload -U bashcompinit && bashcompinit' .zshrc

init_ok
