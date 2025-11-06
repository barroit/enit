# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Installing gcc from source'

if ! test_force_run && [ "$(command -v gcc)" = $HOME/.local/bin/gcc ]; then
	skip
fi

cd $rtree/..

if [ ! -d gcc/.git ]; then
	rm -rf gcc
	git clone git@github.com:gcc-mirror/gcc.git
fi

cd gcc
git fetch

git clean -dxf
git checkout releases/gcc-15.2.0

./contrib/download_prerequisites

mkdir build
cd build

CC=gcc-14 CXX=g++-14 ../configure --disable-multilib --prefix=$HOME/.local

trap 'rm -f .tmp-$$' EXIT

while true; do
	make -j$(nproc) BOOT_CFLAGS='-O2' bootstrap && break || true

	printf '\n' >>.tmp-$$

	if [ $(cat .tmp-$$ | wc -l) = 5 ]; then
		die 'too many errors'
	fi
done

make install

ok
