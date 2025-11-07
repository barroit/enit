#!/bin/zsh
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

export ctree=$(dirname $(readlink -f $0))

source $ctree/lib39.sh
source $ctree/libnit.sh

source $1
