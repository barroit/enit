# SPDX-License-Identifier: GPL-3.0-or-later

rm -f target
ln -s $(kernel_id) target

info "Linking $(kernel_id) to target ... OK"
