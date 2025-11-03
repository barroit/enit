# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && command -v tailscale >/dev/null; then
	info 'Installing tailscale ... Skipped'
	exit
fi

go install tailscale.com/cmd/tailscale{,d}@main

mkdir -p .local/bin
ln -sf $HOME/go/bin/tailscale .local/bin/

sudo $HOME/go/bin/tailscaled install-system-daemon

note 'set up tailscale by running:

	tailscale up --login-server https://node.barroit.sh --authkey <key>
'

info 'Installing tailscale ... OK'
