# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_force_run && launchctl list | grep -q sh.barroit.wasabi; then
	info 'Setting up wasabi ... Skipped'
	exit
fi

mkdir -p Library/LaunchAgents
cd Library/LaunchAgents

cat <<EOF >sh.barroit.wasabi.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
                       "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>sh.barroit.wasabi</string>

    <key>ProgramArguments</key>
    <array>
      <string>$etctree/scripts/wasabi.launchd.sh</string>
    </array>

    <key>RunAtLoad</key>
    <true/>
  </dict>
</plist>
EOF

launchctl bootout gui/$(id -u) sh.barroit.wasabi.plist 2>/dev/null || true
launchctl bootstrap gui/$(id -u) sh.barroit.wasabi.plist

info 'Setting up wasabi ... OK'
