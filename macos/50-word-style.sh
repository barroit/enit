# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Setting zsh word style'

skip_inited

write_on_miss 'autoload -U select-word-style && select-word-style bash' .zshrc

init_ok
