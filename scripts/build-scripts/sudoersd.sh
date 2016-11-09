#!/bin/sh

# keep the ssh auth socket, useful when forwarding the ssh agent from the host to the guest
cat > /etc/sudoers.d/envkeep << EOF
Defaults env_keep += SSH_AUTH_SOCK
EOF

chmod 440 /etc/sudoers.d/envkeep
