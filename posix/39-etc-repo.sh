# SPDX-License-Identifier: GPL-3.0-or-later

cd $rtree/..

if [ ! -d etc ]; then
	git clone https://github.com/barroit/etc.git
fi

cd etc

git remote set-url origin git@github.com:barroit/etc.git

files=$(grep filter=etc .gitattributes | awk '{ print $1 }')

rm -f $files
git restore -- $files

info 'Deploying etc.git ... OK'
