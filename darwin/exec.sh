#!/bin/zsh
# SPDX-License-Identifier: GPL-3.0-or-later

export ctree=$(dirname $(readlink -f $0))

source $ctree/lib39.sh
source $ctree/libsetup.sh

source $1
