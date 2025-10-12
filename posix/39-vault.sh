# SPDX-License-Identifier: GPL-3.0-or-later

set +e

require_vault

for file in $(ls $vault); do
	case $file in
	pg_*.gpg)
		if ! confirm "import '$file'"; then
			continue
		fi

		gpg --import $vault/$file

		if [ $? -ne 0 ]; then
			error "failed to import '$file'"
			continue
		fi
		;;

	id_*.gpg)
		if ! confirm "decrypt '$file' to $HOME/.ssh"; then
			continue
		fi

		name=${file%.gpg}
		dst=.ssh/$name

		gpg --yes --output $dst --decrypt $vault/$file

		if [ $? -ne 0 ]; then
			error "failed to decrypt '$name'"
			continue
		fi

		chmod 0600 $dst
		;;

	*)
		continue

	esac

	info "Importing ${name:-$file} ... DONE"
done

info 'Deploying vault items ... OK'
