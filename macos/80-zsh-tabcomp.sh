# SPDX-License-Identifier: GPL-3.0-or-later

touch .zshrc

wrote_on_miss_sh 'autoload -Uz compinit && compinit' .zshrc

info 'Adding Z shell autocompletion ... OK'
