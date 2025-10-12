# SPDX-License-Identifier: GPL-3.0-or-later

download=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if ! test_force_run && test_init_done; then
	info 'Installing vim plug ... Skipped'
	exit
fi

plug=.vim/autoload/plug.vim

mkdir -p $(dirname $plug)
curl -o $plug $download

mark_init_done
info 'Installing vim plug ... OK'
