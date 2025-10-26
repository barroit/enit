# SPDX-License-Identifier: GPL-3.0-or-later

touch .zshrc

write_on_miss_sh 'eval "$(register-python-argcomplete pipx)"' .zshrc

info 'Adding pipx autocompletion to Z shell ... OK'
