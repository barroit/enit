# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Setting power management'

skip_inited

class=ac

if test_laptop; then
	class=battery
fi

idle=$(col_2 $vartree/pm-timeout $class)
suspend=$(col_3 $vartree/pm-timeout $class)

gsettings set org.gnome.settings-daemon.plugins.power \
	  power-button-action 'suspend'

gsettings set org.gnome.desktop.session idle-delay $idle

gsettings set org.gnome.settings-daemon.plugins.power \
	  sleep-inactive-$class-type 'suspend'

gsettings set org.gnome.settings-daemon.plugins.power \
	  sleep-inactive-$class-timeout $suspend

init_ok
