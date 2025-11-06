# SPDX-License-Identifier: GPL-3.0-or-later
#
# Don't put these into .profile or .zprofile. Well zsh treats every shell as
# login shell by default, bash does not.

write_on_miss 'export GPG_TTY=$(tty)' ${dotsh}_agent

write_on_miss 'export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)' \
	      ${dotsh}_agent

write_on_miss "[ -f \$HOME/${dotsh}_agent ] && . \$HOME/${dotsh}_agent" \
	      ${dotsh}rc

gpg-connect-agent reloadagent /bye >/dev/null

info 'Setting ssh agent to gpg-agent ... OK'
