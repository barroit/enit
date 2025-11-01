# SPDX-License-Identifier: GPL-3.0-or-later

write_on_miss 'autoload -Uz compinit && compinit' .zshrc
write_on_miss 'autoload -U bashcompinit && bashcompinit' .zshrc

info 'Adding Z shell autocompletion ... OK'
