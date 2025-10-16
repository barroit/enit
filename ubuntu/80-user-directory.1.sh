# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Creating user directories ... Skipped'
	exit
fi

rm -rf Desktop
ln -snf /tmp/desktop desktop

ln -snf /tmp/download download
rm -rf Downloads

rm -rf Documents
mkdir -p document

rm -rf Videos
mkdir -p video

rm -rf Pictures
mkdir -p picture

mkdir -p screenshot
ln -snf ../screenshot picture/Screenshots

rm -rf Music
rm -rf Templates
rm -rf Public

ln -snf /tmp/sandbox sandbox
ln -snf /media/$USER media

mark_init_done
info 'Creating user directories ... OK'
