#!/bin/bash

mkdir ~vagrant/.ssh
curl -o ~vagrant/.ssh/authorized_keys \
    https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub
chown -R vagrant ~vagrant/.ssh
chmod -R go-rwsx ~vagrant/.ssh
