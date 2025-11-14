# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG="Writing which-lib39 to $bin"

skip_installed which-lib39

cd $bin

cat <<EOF >which-lib39
#!/bin/sh

printf '$rtree/lib39/flavor.sh\n' 
EOF

chmod +x which-lib39

ok
