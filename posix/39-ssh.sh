# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Wrapping ssh'

! test_force_run && [ $(command -v ssh) = $HOME/.local/bin/ssh ] && skip

mkdir -p .local/bin
cd .local/bin

cat <<EOF >ssh
#!/bin/sh
# $(wrote)

set -e

gpg-connect-agent updatestartuptty /bye >/dev/null

$(env -i sh -c 'command -v ssh') "\$@"
EOF

chmod +x ssh

ok
