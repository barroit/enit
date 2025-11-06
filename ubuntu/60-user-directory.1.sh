# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Mapping user directories'

skip_inited

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

init_ok
