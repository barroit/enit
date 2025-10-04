#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Installing vim plug ... Skipped'
	exit
fi

dst=$HOME/.vim/autoload/plug.vim

if [[ ! -f $dst ]]; then
	mkdir -p $(dirname $dst)
fi

curl -Lo $dst $(cat $CONFIG_ROOT/vim-plug-url)

mark_init_done
info 'Installing vim plug ... OK'
