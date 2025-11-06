# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Configuring public key authentication'

skip_inited

mkdir -p .ssh
cd .ssh

trap 'rm -f .tmp-$$' EXIT
gpg --export-ssh-key $pub_key! >.tmp-$$

cat .tmp-$$ | write_on_miss authorized_keys

init_ok
