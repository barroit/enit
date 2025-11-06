# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Installing JetBrains Mono'

dir=$HOME/.local/share/fonts/jetbrains-mono

! test_force_run &&
[ -n "$(find $dir -name '*.ttf' -o -name '*.woff2')" ] && skip

url=https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
zip=$(basename $url)

trap 'cd .. && rm -rf .tmp-$$' EXIT
mkdir .tmp-$$
cd .tmp-$$

curl -sLo $zip $url
unzip -q $zip

rm -rf $dir
mv fonts $dir

fc-cache $dir

ok
