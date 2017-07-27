#!/bin/sh -eux

# set selinux to permissive mode

selinux_config=/etc/selinux/config

if [ -f $selinux_config ]; then
  sed -i "s/^\(SELINUX=\).*$/\1permissive/" $selinux_config
  sed -i "s/^\(SELINUXTYPE=\).*$/\1targeted/" $selinux_config
fi
