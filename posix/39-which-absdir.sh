# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Generating helper for locating absolute path of script directory'

skip_installed which-absdir

cd $bin

cat <<'EOF' >which-absdir
#!/bin/sh

if [ -n "$1" ] && command -v $1 >/dev/null; then
	dirname $(realpath $(command -v $1))
else
	exit 1
fi
EOF

chmod +x which-absdir

ok
