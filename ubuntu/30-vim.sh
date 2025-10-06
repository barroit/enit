# SPDX-License-Identifier: GPL-3.0-or-later

repo=git@github.com:vim/vim.git
tag=v9.1.1830

set -e

if ! test_force_run && [ $(command -v vim) = $HOME/.local/bin/vim ]; then
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
