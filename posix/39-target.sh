# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG="Linking $(kernel_id) to target"

! test_force_run && [ -L $rtree/target ] && skip

cd $rtree

rm -f target
ln -s $(kernel_id) target

ok
