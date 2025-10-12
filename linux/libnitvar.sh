# SPDX-License-Identifier: GPL-3.0-or-later

export data=$HOME/.local/share/barroit

export bin=$HOME/.local/bin

export vault=/media/$(whoami)/vault

export sshd_key=$(test_vm && printf id_lvm_noble || printf id_dev_ubuntu)
