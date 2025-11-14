# SPDX-License-Identifier: GPL-3.0-or-later
 
INFO_MESG="Prefixing \$PATH with $HOME/.local/bin"

skip_inited

write_on_miss "export PATH=\"$HOME/.local/bin:\$PATH\"" .zshrc

init_ok
