# SPDX-License-Identifier: GPL-3.0-or-later

touch ${dotsh}_prompt

write_on_miss_sh "$(cat <<EOF | oneline
branch_detached()
{
	! git symbolic-ref HEAD >/dev/null 2>&1;
}
EOF
)" ${dotsh}_prompt

write_on_miss_sh "$(cat <<EOF | oneline
branch_diverged()
(
	exec >/dev/null 2>&1 &&
	git rev-parse @{u} &&
	test \$(git rev-parse HEAD) != \
	     \$(git merge-base \$(git rev-parse HEAD) \$(git rev-parse @{u}));
)
EOF
)" ${dotsh}_prompt

write_on_miss_sh "$(cat <<EOF | oneline
branch_synced()
(
	exec >/dev/null 2>&1 &&
	git rev-parse @{u} &&
	test \$(git rev-parse HEAD) = \$(git rev-parse @{u});
)
EOF
)" ${dotsh}_prompt

write_on_miss_sh "$(cat <<EOF | oneline
branch_modified()
(
	exec >/dev/null 2>&1 &&
	git rev-parse HEAD &&
	! git diff-index --quiet HEAD ||
	test -n "\$(git ls-files --others --exclude-standard)";
)
EOF
)" ${dotsh}_prompt

write_on_miss_sh "$(cat <<EOF | oneline
branch_now()
{
	git rev-parse --abbrev-ref HEAD 2>/dev/null || true;
}
EOF
)" ${dotsh}_prompt

write_on_miss_sh "$(cat <<EOF | oneline
branch_stat_dumb()
{
	branch_detached || branch_diverged && printf '!' ||
	{ ! branch_synced && printf '*' || true; } &&
	{ branch_modified && printf '+'; }
}
EOF
)" ${dotsh}_prompt

write_on_miss_sh "[ -f \$HOME/${dotsh}_prompt ] && . \$HOME/${dotsh}_prompt" \
		 ${dotsh}rc

info 'Adding branch helper ... OK'
