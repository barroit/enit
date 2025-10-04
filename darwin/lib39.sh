#!/bin/zsh
# SPDX-License-Identifier: GPL-3.0-or-later

source $ctree/../posix/lib39.sh

function now()
{
	printf '%s\n' $(( $(date +%s) - $(sysctl -n kern.boottime | \
					  awk '{print $4}' | tr -d ,) ))
}

function test_vm()
{
	test 1 -eq 0
}

function test_laptop()
{
	test 1 -eq 1
}
