#!/bin/sh -eux

# Set grub timeout to 0

if command -v lsb_release &>/dev/null; then
  version=$(lsb_release -sr | cut -f1 -d.)
else
  echo "lsb_release is not available, please install redhat-lsb-core" && exit 1
fi

if [[ $version == 6 ]]; then
  sed -i.bak "s/^\(timeout=\).*/\10/" /boot/grub/grub.conf
elif [[ $version == 7 ]]; then
  sed -i.bak "s/^\(GRUB_TIMEOUT=\).*/\10/" /etc/default/grub
  grub2-mkconfig -o /boot/grub2/grub.cfg
else
  echo "unsupported version" && exit 1
fi

