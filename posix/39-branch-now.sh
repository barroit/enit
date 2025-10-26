# SPDX-License-Identifier: GPL-3.0-or-later

touch ${dotsh}_command

write_on_miss_sh "$(cat <<EOF | oneline
branch_now()
{
	git rev-parse --abbrev-ref HEAD 2>/dev/null || true;
}
EOF
)" ${dotsh}_command

write_on_miss_sh "[ -f \$HOME/${dotsh}_command ] && . \$HOME/${dotsh}_command" \
		 ${dotsh}rc

info 'Adding branch_now() ... OK'
