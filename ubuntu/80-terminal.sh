# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done || test_vm; then
	info 'Configuring GNOME Terminal ... Skipped'
	exit
fi

dconf load /org/gnome/terminal/legacy/profiles:/ < $vartree/gnome-terminal

mark_init_done
info 'Configuring GNOME Terminal ... OK'
