#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

ESC="$(printf '\033')"
BOLD="${ESC}[1m"
RED="${ESC}[31m"
YELLOW="${ESC}[33m"
GREEN="${ESC}[32m"
CYAN="${ESC}[36m"
WHITE="${ESC}[37m"
RESET="${ESC}[0m"

die()
{
	printf "${BOLD}${RED}fatal:${RESET} %s\n" "$@" >&2
	exit 128
}

error()
{
	printf "${BOLD}${RED}error:${RESET} %s\n" "$@" >&2
	return 1
}

warn()
{
	printf "${BOLD}${YELLOW}warning:${RESET} %s\n" "$@" >&2
	return 1
}

note()
{
	printf "${BOLD}${CYAN}note:${RESET} %s\n" "$@"
}

info()
{
	printf "${BOLD}${GREEN}[$(boottime)]${RESET} %s\n" "$@"
}

getchar()
{
	if [ -t 0 ]; then
		saved=$(stty -g)

		stty -icanon min 1 time 0
	fi

	eval "$1="

	while true; do
		c=$(dd bs=1 count=1 2>/dev/null; echo .)
		c=${c%.}

		if [ -z "$c" ]; then
			break;
		fi

		eval "$1=\${$1}$c"

		if eval '[ "$(($(printf %s "\${$1}" | wc -m)))" -ne 0 ]'; then
			break;
		fi
	done

	if [ -t 0 ]; then
		stty "$saved"
	fi
}

confirm()
{
	printf '%s [y/N] ' "$1" >&2
	getchar select
	printf '\n'

	case "$select" in
	[yY][eE][sS] | [yY])
		return 0
		;;
	*)
		return 1
		;;
	esac
}

lower()
{
	tr [:upper:] [:lower:]
}

upper()
{
	tr [:lower:] [:upper:]
}

col_1()
{
	grep $2 $1 | awk -F'\t+' '{print $2}'
}

col_2()
{
	grep $2 $1 | awk -F'\t+' '{print $3}'
}

col_3()
{
	grep $2 $1 | awk -F'\t+' '{print $4}'
}

col_4()
{
	grep $2 $1 | awk -F'\t+' '{print $5}'
}


linecol_1()
{
	printf %s "$1" | awk -F'\t+' '{print $1}'
}

linecol_2()
{
	printf %s "$1" | awk -F'\t+' '{print $2}'
}

linecol_3()
{
	printf %s "$1" | awk -F'\t+' '{print $3}'
}

linecol_4()
{
	printf %s "$1" | awk -F'\t+' '{print $4}'
}

need_skip_line()
{
	case "$1" in
	'' | \#*)
		# weird, but works
		return 0
		;;
	*)
		return 1
	esac
}

ini_block()
{
	perl -ne "print if /^\[$1\]$/ .. /^\[end$1\]$/ and !/^\[.*\]$/" $2
}

ini_block_st()
{
	str=$(ini_block $1 $2)

	if [ -z "$str" ]; then
		die "no matching section $1 found in $2"
	fi

	printf '%s\n' "$str"
}
