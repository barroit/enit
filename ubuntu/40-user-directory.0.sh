# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Configuring tmpfiles.d for user directory ... Skipped'
	exit
fi

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

mark_init_done
info 'Configuring tmpfiles.d for user directory ... OK'
