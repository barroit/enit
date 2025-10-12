# SPDX-License-Identifier: GPL-3.0-or-later

export script=$1
export script_id=${1##$(realpath $rtree/..)/}
export etctree=$(realpath $rtree/etc)
export vartree=$rtree/var

. $ctree/libnitvar.sh

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
	basename $(dirname $(realpath $(os_id)/run.sh))
}
