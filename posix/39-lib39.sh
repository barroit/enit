# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG="Generating lib39"

! test_force_run && [ -d $rtree/lib39 ] && skip

cd $rtree

mkdir -p lib39
cd lib39

ln -sf ../$(kernel_id)/lib39.sh flavor.sh
ln -sf ../posix/lib39.sh posix.sh
ln -sf ../posix/lib39.py posix.py

ok
