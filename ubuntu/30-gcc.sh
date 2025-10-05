# SPDX-License-Identifier: GPL-3.0-or-later

set -e

repo=git@github.com:gcc-mirror/gcc.git
tag=releases/gcc-15.2.0

if ! test_force_run && [ $(which gcc) = $HOME/.local/bin/gcc ]; then
	info 'Installing GCC from source ... Skipped'
	exit
fi

if test_vm; then
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-14 99
	sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-14 99

	info 'Linking GCC ... OK'
	exit
fi

cd

mkdir -p git
cd git

if [ ! -d gcc ]; then
	git clone $repo
fi

cd gcc

old=$(git rev-parse --short HEAD)
new=$(git rev-parse --short $tag^{})

if [ $old != $new ]; then
	git clean -xdf
fi

git checkout $tag

./contrib/download_prerequisites

mkdir -p build
cd build

if [ -f Makefile ]; then
	make distclean
fi

CC=gcc-14 CXX=g++-14 ../configure --disable-multilib --prefix=$HOME/.local

trap 'rm -f .retry.tmp' EXIT

while true; do
	make -j$(nproc) BOOT_CFLAGS='-O2' bootstrap && break || true

	printf '\n' >>.retry.tmp

	if [ $(cat .retry.tmp | wc -l) = 5 ]; then
		die 'too many errors'
	fi
done

make install

info 'Installing GCC from source ... OK'
