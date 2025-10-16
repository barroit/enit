# SPDX-License-Identifier: GPL-3.0-or-later

url=https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip

if ! test_force_run && test_init_done || test_vm; then
	info 'Installing JetBrains Mono ... Skipped'
	exit
fi

zip=$(basename $url)
dst=$HOME/.local/share/fonts/jetbrains-mono

trap 'cd .. && rm -rf .tmp-$$' EXIT
mkdir .tmp-$$
cd .tmp-$$

curl -sLo $zip $url
unzip -q $zip

rm -rf $dst
mv fonts $dst

fc-cache $dst

mark_init_done
info 'Installing JetBrains Mono ... OK'
