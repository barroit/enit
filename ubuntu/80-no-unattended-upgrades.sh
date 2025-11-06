# SPDX-License-Identifier: GPL-3.0-or-later

if ! command -v unattended-upgrades; then
	info 'Dropping unattended-upgrades ... Skipped'
	exit
fi

sudo systemctl disable --now unattended-upgrades
sudo apt remove unattended-upgrades

info 'Dropping unattended-upgrades ... OK'
