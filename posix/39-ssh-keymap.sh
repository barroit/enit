# SPDX-License-Identifier: GPL-3.0-or-later

mkdir -p .ssh
cd .ssh

while read class name id; do
	if need_skip_line "$class"; then
		continue
	fi

	pub=${class}_$name.pub

	gpg --export-ssh-key $id! >$pub

	info "exported $id to $PWD/$pub"

done <$vartree/ssh-keymap

info 'Deploying ssh key ... OK'
