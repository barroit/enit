#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

name=$(perl -E 'say $^O')

case $name in
linux)
	name=$(grep '^ID=' /etc/os-release | cut -d= -f2)
	;;

darwin)
	name=macos

esac

$name/init.sh "$@"
