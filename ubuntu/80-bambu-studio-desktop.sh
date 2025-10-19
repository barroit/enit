# SPDX-License-Identifier: GPL-3.0-or-later

mkdir -p .local/share/applications
cd .local/share/applications

cat <<EOF >bambu-studio.desktop
[Desktop Entry]
Name=Bambu Studio
StartupWMClass=bambu-studio
Type=Application
Comment=3D Slicing and Print Management
Exec=$HOME/.bambu/bin/bambu-studio %U
Icon=$HOME/.bambu/resources/web/image/logo.png
Categories=Development;Graphics;3DGraphics;
StartupNotify=false
EOF

info 'Generating bambu-studio.desktop ... OK'
