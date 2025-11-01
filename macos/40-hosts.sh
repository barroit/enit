# SPDX-License-Identifier: GPL-3.0-or-later

cat <<EOF | pretee=sudo write_on_miss /etc/hosts
127.0.0.1       macos.dev
EOF

info 'Aliasing 127.0.0.1 ... OK'
