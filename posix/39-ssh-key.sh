# SPDX-License-Identifier: GPL-3.0-or-later

trap 'rm -f .tmp-$$' EXIT

while read id grip; do
	if need_skip_line "$id"; then
		continue
	fi

	gpg-connect-agent "keyattr $grip Use-for-ssh: true" /bye >.tmp-$$

	if ! grep -xqF 'OK' .tmp-$$; then
		warn "failed to enable key $id for ssh, $(cat .tmp-$$)" || true
	else
		info "enabled gpg key $id for ssh"
	fi

done <$vartree/ssh-key

info 'Push gpg key to ssh agent ... OK'
