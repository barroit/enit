#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done || test_vm; then
	info 'Installing JetBrains Mono ... Skipped'
	exit
fi

url=$(cat $vartree/jb-mono-url)
zip=$(basename $url)

tmp=$(mktemp -d)
dst=~/.local/share/fonts/jetbrains-mono

trap 'rm -rf "$tmp"' EXIT

cd $tmp

curl -L -o $zip $url
unzip $zip

rm -rf $dst
mv fonts $dst

fc-cache -f

mark_init_done
info 'Installing JetBrains Mono ... OK'
