# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Configuring perf events'

skip_inited

cat <<EOF | sudo tee /etc/sysctl.d/39-perf.conf >/dev/null
kernel.perf_event_paranoid = -1
EOF

sudo service procps reload

init_ok
