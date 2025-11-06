# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Cloning etc.git'

! test_force_run && [ -d $etctree/.git ] && skip

cd $(dirname $etctree)

rm -rf etc
git clone https://github.com/barroit/etc.git

cd etc
git remote set-url origin git@github.com:barroit/etc.git

ok
