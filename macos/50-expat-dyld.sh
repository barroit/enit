# SPDX-License-Identifier: GPL-3.0-or-later
 
INFO_MESG="Fixing libexpat path for homebrew python3"

skip_inited

write_on_miss .zshrc <<EOF
export DYLD_LIBRARY_PATH=/opt/homebrew/opt/expat/lib:$DYLD_LIBRARY_PATH
EOF

init_ok
