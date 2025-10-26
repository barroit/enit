# SPDX-License-Identifier: GPL-3.0-or-later

touch .zshrc

write_on_miss_sh 'setopt HIST_IGNORE_DUPS' .zshrc

info 'Setting Z shell history behavior ... OK'
