# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG="Adding tailscale completion for $shell"

skip_inited

tailscale completion $shell >${dotsh}_tailscale

cat <<EOF | write_on_miss ${dotsh}rc
[ -f \$HOME/${dotsh}_tailscale ] && . \$HOME/${dotsh}_tailscale
EOF

init_ok
