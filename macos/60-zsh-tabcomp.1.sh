# SPDX-License-Identifier: GPL-3.0-or-later

touch .zshrc

wrote_on_miss_sh 'autoload -U bashcompinit && bashcompinit' .zshrc

info 'Adding bash autocompletion compatibility for Z shell ... OK'
