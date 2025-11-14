#!/bin/zsh
# SPDX-License-Identifier: GPL-3.0-or-later

function lib39dir()
{
	dirname $(realpath ${(%):-%x})
}

source $(lib39dir)/../posix/lib39.sh

function __kboottime()
{
	sysctl -n kern.boottime | cut -d' ' -f4 | cut -d',' -f1
}

function boottime()
{
	printf '%s\n' $(( $(date +%s) - $(__kboottime) ))
}

function test_vm()
{
	test 1 -eq 0
}

function test_laptop()
{
	test 1 -eq 1
}
