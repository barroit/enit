#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later

source $ctree/../posix/lib39.sh

function now()
{
	cut -d' ' -f2 /proc/uptime
}

function test_vm()
{
	test $(systemd-detect-virt) != none
}

function test_laptop()
{
	ls /sys/class/power_supply/BAT* >/dev/null 2>&1
}
