# SPDX-License-Identifier: GPL-3.0-or-later

if test_vm; then
	info 'Aliasing 127.0.0.1 ... Skipped'
fi

cat <<EOF | pretee=sudo write_on_miss /etc/hosts
127.0.0.1       ubuntu.dev
EOF

info 'Aliasing 127.0.0.1 ... OK'
