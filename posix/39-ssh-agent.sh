# SPDX-License-Identifier: GPL-3.0-or-later
#
# Don't put these into .profile or .zprofile. Well zsh treats every shell as
# login shell by default, bash does not.

INFO_MESG='Setting ssh agent to gpg-agent'

skip_inited

write_on_miss 'export GPG_TTY=$(tty)' ${dotsh}rc

cat <<'EOF' | oneline | write_on_miss ${dotsh}rc
[ -z "$SSH_CONNECTION" ] &&
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
EOF

gpg-connect-agent reloadagent /bye >/dev/null

init_ok
