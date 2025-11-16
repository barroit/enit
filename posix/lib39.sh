#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

ESC=$(printf '\033')
TAB=$(printf '\011')

LF=$(printf '\012y')
CRLF=$(printf '\015')$LF

LF=${LF%y}
CRLF=${CRLF%y}

BOLD=${ESC}[1m
RED=${ESC}[31m
YELLOW=${ESC}[33m
GREEN=${ESC}[32m
CYAN=${ESC}[36m
WHITE=${ESC}[37m
RESET=${ESC}[0m

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
		c=$(dd bs=1 count=1 2>/dev/null; printf '.\n')
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

col_2()
{
	grep $2 $1 | awk -F'\t+' '{print $2}'
}

col_3()
{
	grep $2 $1 | awk -F'\t+' '{print $3}'
}

col_4()
{
	grep $2 $1 | awk -F'\t+' '{print $4}'
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

blk39_find()
{
	perl -ne "print if /^\[$1\]$/ .. /^\[\/$1\]$/ and !/^\[.*\]$/" $2
}

blk39_keys()
{
	grep '^\[[^/].*\]$' $1 | tr -d []
}

on_date()
{
	printf 'On %s\n' "$(date '+%a, %b %d, %Y at %H:%M:%S%p %z')"
}

oneline()
{
	tr -d '\t' | tr -s '\n' ' ' | sed 's/ *$//'
}

urlsafe()
{
	{ [ -n "$1" ] && printf '%s' "$1" || cat; } | jq -Rr @uri
}
