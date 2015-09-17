#!/bin/bash -eux

mkdir -p /tmp/chef
pushd /tmp/chef
wget https://opscode-omnibus-packages.s3.amazonaws.com/el/7/x86_64/chefdk-0.6.2-1.el7.x86_64.rpm
yum localinstall -y chefdk-0.6.2-1.el7.x86_64.rpm
popd
rm -rf /tmp/chef
