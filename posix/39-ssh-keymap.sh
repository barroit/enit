# SPDX-License-Identifier: GPL-3.0-or-later

mkdir -p .ssh
cd .ssh

trap 'rm -f .tmp-$$' EXIT

while read class name id; do
	if need_skip_line "$class"; then
		continue
	fi

	pub=${class}_$name.pub

	gpg --export-ssh-key $id! >$pub 2>.tmp-$$ || true

	if [ -s .tmp-$$ ]; then
		msg=$(head -n1 .tmp-$$ | cut -d: -f3 | lower)

		warn "failed to export $id to $PWD/$pub,$msg" || true

	else
		chmod 0600 $pub
		info "exported $id to $PWD/$pub"
	fi

done <$vartree/ssh-keymap

info 'Deploying ssh key ... OK'
