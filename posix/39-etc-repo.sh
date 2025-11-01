# SPDX-License-Identifier: GPL-3.0-or-later

cd $rtree/..

if [ ! -d etc ]; then
	git clone https://github.com/barroit/etc.git
fi

cd etc

git remote set-url origin git@github.com:barroit/etc.git

info 'Cloning etc.git ... OK'
