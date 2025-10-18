# SPDX-License-Identifier: GPL-3.0-or-later

touch .bashrc

wrote_on_miss_sh 'eval "$(register-python-argcomplete pipx)"' .bashrc

info 'Adding pipx autocompletion to bash ... OK'
