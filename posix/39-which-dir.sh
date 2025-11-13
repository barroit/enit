# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Generating helper for locating script directory'

skip_installed which-dir

cd $bin

cat <<'EOF' >which-dir
#!/bin/sh

if [ -n "$1" ] && command -v $1 >/dev/null; then
	dirname $(command -v $1)
else
	exit 1
fi
EOF

chmod +x which-dir

ok
