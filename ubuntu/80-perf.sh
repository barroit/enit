# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Configuring perf permissions ... Skipped'
	exit
fi

printf '%s\n' 'kernel.perf_event_paranoid = -1' | \
sudo tee /etc/sysctl.d/39-perf.conf

sudo service procps reload

mark_init_done
info 'Configuring perf permissions ... OK'
