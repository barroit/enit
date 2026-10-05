# SPDX-License-Identifier: GPL-3.0-or-later


INFO_MESG="Enabling i-search for $shell"

skip_inited

cat <<EOF | write_on_miss ${dotsh}rc
stty -ixon
EOF

init_ok
