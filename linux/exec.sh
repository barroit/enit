#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later

export ctree=$(dirname $(realpath $(readlink $0)))

source $ctree/lib39.sh
source $ctree/libsetup.sh

source $1
