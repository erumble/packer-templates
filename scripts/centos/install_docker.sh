#!/bin/bash -eux

# run this script with sudo

# need 2 lines here because the latter depends on the former
yum install -y epel-release 
yum install -y docker-io

# add user vagrant to group docker
usermod -a -G docker vagrant

# start docker and make it start on boot
service docker start
chkconfig docker on

