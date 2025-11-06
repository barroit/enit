# SPDX-License-Identifier: GPL-3.0-or-later

cat <<EOF | oneline | write_on_miss ${dotsh}_prompt
branch_detached()
{
	! git symbolic-ref HEAD >/dev/null 2>&1;
}
EOF

cat <<EOF | oneline | write_on_miss ${dotsh}_prompt
branch_diverged()
(
	exec >/dev/null 2>&1 &&
	git rev-parse @{u} &&
	test \$(git rev-parse HEAD) != \
	     \$(git merge-base \$(git rev-parse HEAD) \$(git rev-parse @{u}));
)
EOF

cat <<EOF | oneline | write_on_miss ${dotsh}_prompt
branch_synced()
(
	exec >/dev/null 2>&1 &&
	git rev-parse @{u} &&
	test \$(git rev-parse HEAD) = \$(git rev-parse @{u});
)
EOF

cat <<EOF | oneline | write_on_miss ${dotsh}_prompt
branch_modified()
(
	exec >/dev/null 2>&1 &&
	git rev-parse HEAD &&
	! git diff-index --quiet HEAD ||
	test -n "\$(git ls-files --others --exclude-standard)";
)
EOF

cat <<EOF | oneline | write_on_miss ${dotsh}_prompt
branch_now()
{
	git rev-parse --abbrev-ref HEAD 2>/dev/null || true;
}
EOF

cat <<EOF | oneline | write_on_miss ${dotsh}_prompt
branch_stat_dumb()
{
	branch_detached || branch_diverged && printf '!' ||
	{ ! branch_synced && printf '*' || true; } &&
	{ branch_modified && printf '+'; }
}
EOF

write_on_miss "[ -f \$HOME/${dotsh}_prompt ] && . \$HOME/${dotsh}_prompt" \
	      ${dotsh}rc

ok "Adding git helper to $shell"
