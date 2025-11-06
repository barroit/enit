# SPDX-License-Identifier: GPL-3.0-or-later

export script=$1
export script_id=${1##$(realpath $rtree/..)/}
export etctree=$(realpath $rtree/etc)
export vartree=$rtree/var

. $ctree/libnitvar.sh

export dotsh=.$shell

mkdir -p "$data"
mkdir -p "$bin"

test_init_done()
{
	test -f "$data/$(basename $script)"
}

mark_init_done()
{
	touch "$data/$(basename $script)"
}

test_force_run()
{
	printf '%s\n' $force | grep -xqF $script
}

test_same_commit()
{
	test $(git rev-parse --short HEAD) = "$(git rev-parse --short $1^{})"
}

os_id()
{
	basename $(dirname $script)
}

kernel_id()
{
	basename $(dirname $(realpath $stree/run.sh))
}

require_vault()
{
	if [ ! -d $vault ]; then
		die "vault not mounted at $vault"
	fi
}

wrote()
{
	printf '%s, %s wrote:\n' "$(on_date)" $script_id
}

write_on_miss()
(
	trap 'rm -f "$data/.tmp-$$"' EXIT

	if [ -n "$2" ]; then
		printf '%s\n' "$1" >"$data/.tmp-$$"
		shift
	else
		cat >"$data/.tmp-$$"
	fi

	if grep -sxqFf "$data/.tmp-$$" $1; then
		exit
	fi

	cat <<-EOF | $pretee tee -a $1 >/dev/null

	${prewrote:-#} $(wrote)
	$(cat "$data/.tmp-$$")
	EOF
)

oneline()
{
	tr -d '\t' | tr -s '\n' ' ' | sed 's/ *$//'
}

ok()
{
	info "${1:-$INFO_MESG} ... OK"
	exit
}

skip()
{
	info "${1:-$INFO_MESG} ... Skipped"
	exit
}

init_ok()
{
	mark_init_done
	ok
}

skip_inited()
{
	if ! test_force_run && test_init_done; then
		skip
	fi
}

skip_installed()
{
	if ! test_force_run && command -v $1 >/dev/null; then
		skip
	fi
}
