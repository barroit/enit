# SPDX-License-Identifier: GPL-3.0-or-later
# Use absolute command path in ProgramArguments, user agent lacks
# environment.

mkdir -p Library/LaunchAgents
cd Library/LaunchAgents

while read remote local; do
	mnt=$(eval printf '%s' $local)
	id=sh.barroit.wasabi.$(printf '%s' $remote | cut -d':' -f2)
	plist=$id.plist

	cat <<-EOF >$plist
	<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
			       "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	<plist version="1.0">
	  <dict>
	    <key>Label</key>
	    <string>$id</string>

	    <key>ProgramArguments</key>
	    <array>
	      <string>$(command -v rclone)</string>
	      <string>mount</string>
	      <string>--vfs-cache-mode=full</string>
	      <string>$remote</string>
	      <string>$mnt</string>
	    </array>

	    <key>KeepAlive</key>
	    <true/>

	    <key>LaunchOnlyOnce</key>
	    <true/>

	    <key>StandardErrorPath</key>
	    <string>$HOME/Library/Logs/$id/error</string>
	  </dict>
	</plist>
	EOF

	if ! launchctl list | grep -q $id; then
		launchctl bootstrap gui/$(id -u) $plist
	fi

done <$vartree/wasabi

info 'Setting up wasabi ... OK'
