# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Dropping unattended-upgrades'

! test_force_run && ! command -v unattended-upgrades && skip

sudo systemctl disable --now unattended-upgrades
sudo apt remove unattended-upgrades

ok
