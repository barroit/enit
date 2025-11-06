# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Preparing tmpfiles for user directory'

skip_inited

mkdir -p .config/user-tmpfiles.d
cd .config/user-tmpfiles.d

cat <<EOF >user-directory.conf
d!	/tmp/desktop	-	-	-	-
d!	/tmp/download	-	-	-	-
d!	/tmp/sandbox	-	-	-	-
d!	/tmp/dirnull	-	-	-	-
EOF

systemd-tmpfiles --user --create --boot user-directory.conf

systemctl --user enable --now systemd-tmpfiles-setup.service
systemctl --user enable --now systemd-tmpfiles-clean.timer

init_ok
