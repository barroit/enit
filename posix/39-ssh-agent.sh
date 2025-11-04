# SPDX-License-Identifier: GPL-3.0-or-later

write_on_miss 'export GPG_TTY=$(tty)' ${dotsh}rc

cat <<'EOF' | write_on_miss ${dotsh}rc
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
EOF

mkdir -p .local/bin
cd .local/bin

cat <<EOF >ssh
#!/bin/sh

set -e

gpg-connect-agent updatestartuptty /bye >/dev/null

$(sh -c 'command -v ssh') "\$@"
EOF

gpg-connect-agent reloadagent /bye >/dev/null

info 'Setting ssh agent to gpg-agent ... OK'
