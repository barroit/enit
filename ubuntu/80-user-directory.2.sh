# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && test_init_done; then
	info 'Redirecting user directories ... Skipped'
	exit
fi

xdg-user-dirs-update --set DESKTOP	$HOME/desktop
xdg-user-dirs-update --set DOWNLOAD	$HOME/download
xdg-user-dirs-update --set DOCUMENTS	$HOME/document
xdg-user-dirs-update --set PICTURES	$HOME/picture
xdg-user-dirs-update --set VIDEOS	$HOME/video
xdg-user-dirs-update --set TEMPLATES	/tmp/dirnull
xdg-user-dirs-update --set PUBLICSHARE	/tmp/dirnull
xdg-user-dirs-update --set MUSIC	/tmp/dirnull

mark_init_done
info 'Redirecting user directories ... OK'
