#!/bin/zsh
# SPDX-License-Identifier: GPL-3.0-or-later

if [[ ! $ctree ]]; then
	exit 128
fi

source $ctree/../posix/lib39.sh

function current()
{
	printf '%s\n' $(( $(date +%s) - $(sysctl -n kern.boottime | \
					  awk '{print $4}' | tr -d ,) ))
}

function virt()
{
	test 1 -eq 0
}

function laptop()
{
	test 1 -eq 1
}
