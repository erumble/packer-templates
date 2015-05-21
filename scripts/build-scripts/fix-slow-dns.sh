#!/bin/bash -eux

# https://github.com/mitchellh/vagrant/issues/1172
# add 'single-request-reopen' to /etc/sysconfig/network 
# so it will take effect on all interfaces regardless of name.
echo 'RES_OPTIONS="single-request-reopen"' >> /etc/sysconfig/network
service network restart
echo 'Slow DNS fix applied (RES_OPTION="single-request-reopen" added to /etc/sysconfig/network)'
