# SPDX-License-Identifier: GPL-3.0-or-later

cd $etctree

files=$(grep filter=etc .gitattributes | awk '{ print $1 }')

rm -f $files
git restore -- $files

info 'Smudging etc ... OK'
