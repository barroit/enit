# SPDX-License-Identifier: GPL-3.0-or-later

cd $etctree

grep filter=etc .gitattributes | awk '{ print $1 }' | while read name; do
	rm -f $name
	git restore -- $name
done

ok 'Appling etc filters'
