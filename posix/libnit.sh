#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

export script=$1
export etctree=$(realpath $rtree/etc)
export vartree=$rtree/var

. $ctree/libnitvar.sh

mkdir -p "$data"

test_init_done()
{
	test -f $data/$script
}

mark_init_done()
{
	touch $data/$script
}

test_force_run()
{
	test $script = "$force"
}

os_id()
{
	basename $(dirname $0)
}
