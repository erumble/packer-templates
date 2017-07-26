#!/bin/sh -eux

# Set grub timeout to 0

grub_config=/etc/default/grub

if [ -f $grub_config ]; then
  sed -i "s/^\(GRUB_TIMEOUT=\).*/\10/" $grub_config
fi

grub2-mkconfig -o /boot/grub2/grub.cfg
