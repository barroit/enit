#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later

if ! test_vm; then
	powerprofilesctl set power-saver
else
	powerprofilesctl set performance
fi

info 'Adjusting power mode ... OK'
