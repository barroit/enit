# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Installing tailscale'

skip_installed tailscale

curl -fsSL https://tailscale.com/install.sh | sh

ok
