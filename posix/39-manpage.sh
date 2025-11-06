# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Installing posix man pages'

! test_force_run && [ -d $rtree/../man-pages-posix/.git ] && skip

cd $rtree/..

if [ ! -d man-pages-posix/.git ]; then
	rm -rf man-pages-posix
	git clone \
	    https://git.kernel.org/pub/scm/docs/man-pages/man-pages-posix.git
fi

cd man-pages-posix
git fetch

git clean -dxf
git checkout master

cd man-pages-posix-2017

make install prefix=$HOME/.local

ok
