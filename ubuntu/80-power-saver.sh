#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Setting power saver ... Skipped'
	exit
fi

type=desk
power=ac

if test_laptop; then
	type=lap
	power=battery
fi

blank=$(col_1 $CONFIG_ROOT/power-mode ${type}_blank)
suspend=$(col_1 $CONFIG_ROOT/power-mode ${type}_suspend)

gsettings set org.gnome.desktop.session idle-delay $blank

gsettings set org.gnome.settings-daemon.plugins.power \
	  sleep-inactive-$power-timeout $(( $suspend * 60))

gsettings set org.gnome.settings-daemon.plugins.power \
	  sleep-inactive-$power-type 'suspend'

mark_init_done
info 'Setting power mode ... OK'
