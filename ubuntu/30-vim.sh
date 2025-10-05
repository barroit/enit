# SPDX-License-Identifier: GPL-3.0-or-later

set -e

repo=git@github.com:vim/vim.git
tag=v9.1.1830

if ! test_force_run && [ $(which vim) = $HOME/.local/bin/gcc ]; then
	info 'Installing Vim from source ... Skipped'
	exit
fi

cd

mkdir -p git
cd git

if [ ! -d vim ]; then
	git clone $repo
fi

cd vim
git fetch

git clean -xdf
git checkout $tag

cd src

CFLAGS='-O2' ./configure --prefix=$HOME/.local

make -j
make install

info 'Installing Vim from source ... OK'
