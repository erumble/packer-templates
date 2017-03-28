#!/bin/bash

vm_description="#### Built With
* [Packer](https://www.packer.io/) v$(packer --version)
* [Vagrant](https://www.vagrantup.com/) v$(vagrant --version | awk '{print $2}')
* [VirtualBox](https://www.virtualbox.org/) v$(VBoxManage --version | awk -F 'r' '{print $1}')"

cat <<EOF > README.md
### Packer templates for CentOS 6 and 7

Inspired by, and heavily borrowed from [Chef Bento Boxes](https://github.com/chef/bento)

${vm_description}

EOF

cat <<'EOF' >> README.md
#### Hosted on [Atlas](https://atlas.hashicorp.com/vagrant)
* [CentOS 6](https://atlas.hashicorp.com/erumble/boxes/centos6-x64) `vagrant init erumble/centos6-x64; vagrant up`
* [CentOS 7](https://atlas.hashicorp.com/erumble/boxes/centos7-x64) `vagrant init erumble/centos7-x64; vagrant up`
EOF

packer build \
  -var "description=${vm_description}" \
  $1
