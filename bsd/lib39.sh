#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

if [ -z "$ctree" ]; then
	exit 128
fi

. $ctree/../posix/lib39.sh

current()
{
	perl -MTime::HiRes=time -E 'printf "%.2f\n", time'
}

virt()
{
	test 1 -eq 1
}

laptop()
{
	test 1 -eq 0
}
