# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Installing vim from source'

if ! test_force_run && [ "$(command -v vim)" = $HOME/.local/bin/vim ]; then
	skip
fi

cd $rtree/..

if [ ! -d vim/.git ]; then
	rm -rf vim
	git clone git@github.com:vim/vim.git
fi

cd vim
git fetch

git clean -dxf
git checkout v9.1.1830

cd src

CFLAGS='-O2' ./configure --prefix=$HOME/.local

make -j
make install

ok
