#!/bin/sh -eux

msg='This system is built by Packer
More information can be found at https://github.com/erumble/packer-templates'

if [ -d /etc/update-motd.d ]; then
	MOTD_CONFIG='/etc/update-motd.d/99-greet'

	cat <<-MOTD >> "$MOTD_CONFIG"
	#!/bin/sh

	cat <<'EOF'
	$msg
	EOF
	MOTD

	chmod 0755 "$MOTD_CONFIG"
else
	echo "$msg" >> /etc/motd
fi
