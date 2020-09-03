#!/bin/bash

external_commands=(packer vagrant VBoxManage)
for c in ${external_commands[@]}; do
  if ! command -v $c &> /dev/null; then
    printf "Command '$c' could not be found\n"
    exit 1
  fi
done

if [[ $# != 1 ]]; then
  printf "Please specify the path to the Packer template\n"
  exit 1
fi

# create a description of the box to use in Vagrant Cloud
vbox_version=$(VBoxManage --version | awk -F 'r' '{print $1}')

vm_description="#### Built With
* [Packer](https://www.packer.io/) v$(packer --version)
* [Vagrant](https://www.vagrantup.com/) v$(vagrant --version | awk '{print $2}')
* [VirtualBox](https://www.virtualbox.org/) v${vbox_version}"

packer_args=(
  -var "description=${vm_description}"
  -var "version=${vbox_version}"
)

if [[ -z $VAGRANT_CLOUD_TOKEN ]]; then
  packer_args+=(-except=vagrant-cloud)
else
  packer_args+=(-var "vagrant_cloud_token=$VAGRANT_CLOUD_TOKEN")
fi

# do the build
packer build \
  "${packer_args[@]}" \
  $1

