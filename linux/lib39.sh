# SPDX-License-Identifier: GPL-3.0-or-later

function lib39dir()
{
	dirname $(realpath ${BASH_SOURCE[0]})
}

source $(lib39dir)/../posix/lib39.sh

function boottime()
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
