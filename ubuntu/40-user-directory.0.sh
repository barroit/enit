# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Configuring tmpfiles.d for user directory ... Skipped'
	exit
fi

mkdir -p .config/user-tmpfiles.d
cd .config/user-tmpfiles.d

cat <<EOF >user-directory.conf
D!	/tmp/desktop	0755	-	-	-
D!	/tmp/download	0755	-	-	-
D!	/tmp/sandbox	0755	-	-	-
D!	/tmp/dirnull	0755	-	-	-
EOF

systemd-tmpfiles --user --create --boot user-directory.conf

mark_init_done
info 'Configuring tmpfiles.d for user directory ... OK'
