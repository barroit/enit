# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Installing bun'

skip_installed bun

curl -fsSL https://bun.sh/install | bash

write_on_miss 'export BUN_INSTALL="$HOME/.bun"' ${dotsh}rc
write_on_miss 'export PATH="$BUN_INSTALL/bin:$PATH"' ${dotsh}rc

ok
