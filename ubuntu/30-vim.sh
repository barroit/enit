# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && [[ $(which vim) == $HOME* ]]; then
	info 'Compiling Vim ... Skipped'
	exit
fi

mkdir -p git
cd git

if [[ ! -d vim ]]; then
	git clone $(cat $vartree/vim-url)
fi

cd vim/src

make distclean

CFLAGS='-O2' ./configure --prefix=$HOME/.local

make -j

make install

info 'Compiling Vim ... OK'
