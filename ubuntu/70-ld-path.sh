# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG="Adding $HOME/.local/lib to LD_LIBRARY_PATH"

skip_inited

cat <<'EOF' | write_on_miss .bashrc
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
EOF

init_ok
