#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

export ctree=$(dirname $(readlink -f $0))

. $ctree/lib39.sh
. $ctree/libsetup.sh

. $1
