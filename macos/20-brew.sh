# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Installing homebrew'

skip_installed brew

cat <<'EOF' | /bin/bash
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
EOF

ok
