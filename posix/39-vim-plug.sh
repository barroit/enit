# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Installing vim plug'

skip_inited

plug=.vim/autoload/plug.vim

mkdir -p $(dirname $plug)
curl -o $plug \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

init_ok
