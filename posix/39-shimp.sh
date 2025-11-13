# SPDX-License-Identifier: GPL-3.0-or-later
#
# For portable shebang line

INFO_MESG='Linking shell implementation to /usr/local/bin'

skip_installed shimp

sudo ln -sf $(command -v $shell) /usr/local/bin/shimp

ok
