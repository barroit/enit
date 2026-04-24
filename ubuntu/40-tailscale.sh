# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Installing tailscale'

skip_installed tailscale

curl -fsSL https://bun.sh/install | bash

ok
