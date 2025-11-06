# SPDX-License-Identifier: GPL-3.0-or-later

INFO_MESG='Installing flatpak'

skip_installed flatpak

sudo apt install -y flatpak

flatpak remote-add --if-not-exists flathub \
	https://dl.flathub.org/repo/flathub.flatpakrepo

mkdir -p .config/environment.d
cd .config/environment.d

cat <<EOF | while read dir; do
/var/lib/flatpak/exports/share
$HOME/.local/share/flatpak/exports/share
EOF
	write_on_miss "XDG_DATA_DIRS=\"$dir:\$XDG_DATA_DIRS\"" 39-flatpak.conf
done

ok
