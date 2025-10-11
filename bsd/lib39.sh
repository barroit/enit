#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

. $ctree/../posix/lib39.sh

boottime()
{
	perl -MTime::HiRes=time -E 'printf "%.2f\n", time'
}

test_vm()
{
	test 1 -eq 1
}

test_laptop()
{
	test 1 -eq 0
}
