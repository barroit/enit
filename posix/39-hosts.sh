# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG="Aliasing hostname $hostname to 127.0.0.1"

skip_inited

cat <<EOF | pretee=sudo write_on_miss /etc/hosts
127.0.0.1       $hostname
EOF

init_ok
