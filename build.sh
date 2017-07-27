#!/bin/bash

# create a description of the box to use in Vagrant Cloud
vbox_version=$(VBoxManage --version | awk -F 'r' '{print $1}')

vm_description="#### Built With
* [Packer](https://www.packer.io/) v$(packer --version)
* [Vagrant](https://www.vagrantup.com/) v$(vagrant --version | awk '{print $2}')
* [VirtualBox](https://www.virtualbox.org/) v${vbox_version}"

# do the build
packer build \
  -var "description=${vm_description}" \
  -var "version=${vbox_version}" \
  $1
