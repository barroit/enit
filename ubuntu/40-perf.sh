# SPDX-License-Identifier: GPL-3.0-or-later

cat <<EOF | sudo tee /etc/sysctl.d/39-perf.conf >/dev/null
kernel.perf_event_paranoid = -1
EOF

sudo service procps reload

info 'Configuring perf events ... OK'
