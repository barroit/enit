# SPDX-License-Identifier: GPL-3.0-or-later

tailscale completion $shell >${dotsh}_tailscale

cat <<EOF | write_on_miss ${dotsh}rc
[ -f \$HOME/${dotsh}_tailscale ] && . \$HOME/${dotsh}_tailscale
EOF

info "Adding tailscale completion for $shell ... OK"
