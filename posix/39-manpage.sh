# SPDX-License-Identifier: GPL-3.0-or-later

repo=https://git.kernel.org/pub/scm/docs/man-pages/man-pages-posix.git

mkdir -p git
cd git

if [ ! -d man-pages-posix ]; then
	git clone $repo
fi

cd man-pages-posix/man-pages-posix-2017
git pull

git checkout master
git clean -dxf

make install prefix=$HOME/.local

info 'Installing posix man pages ... OK'
