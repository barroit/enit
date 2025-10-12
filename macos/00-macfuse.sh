# SPDX-License-Identifier: GPL-3.0-or-later

guide=https://support.apple.com/en-asia/guide/mac-help/mchl768f7291/mac
endpoint='https://api.github.com/repos/macfuse/macfuse/releases?per_page=1'

if pkgutil --pkg-info io.macfuse.installer.components.core >/dev/null 2>&1; then
	info 'Installing macfuse ... Skipped'
	exit
fi

if ! confirm 'enabled reduced security'; then
	open $guide
	note 'follow guide and enable reduced security, then run this again'
	exit 39
fi

trap 'rm -f .tmp-$$' EXIT
curl -sL \
     -H 'Accept: application/vnd.github+json' \
     -H 'X-GitHub-Api-Version: 2022-11-28' \
     "$endpoint" >.tmp-$$

tag=$(jq -r '.[0].tag_name' .tmp-$$)
name=$tag.dmg
url=$(jq -r '.[0].assets.[] |
	     select(.name == "'$name'").browser_download_url' .tmp-$$)

trap 'rm -f $name' EXIT
curl -sLo $name $url

note "manually install '$name' and restart to complete installation"
exit 39
