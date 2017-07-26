#!/bin/bash

# create a description of the box to use in Atlas and Github
vm_description="#### Built With
* [Packer](https://www.packer.io/) v$(packer --version)
* [Vagrant](https://www.vagrantup.com/) v$(vagrant --version | awk '{print $2}')
* [VirtualBox](https://www.virtualbox.org/) v$(VBoxManage --version | awk -F 'r' '{print $1}')"

# regen the README.md file, be sure to commit and push after a build
cat <<EOF > README.md
### Packer templates for CentOS 6 and 7

Inspired by, and heavily borrowed from [Chef Bento Boxes](https://github.com/chef/bento)

${vm_description}

EOF

# Notice the single quotes around the heredoc delimiter? backticks
cat <<'EOF' >> README.md
#### Hosted on [Atlas](https://atlas.hashicorp.com/vagrant)
* [CentOS 6](https://atlas.hashicorp.com/erumble/boxes/centos6-x64) `vagrant init erumble/centos6-x64; vagrant up`
* [CentOS 7](https://atlas.hashicorp.com/erumble/boxes/centos7-x64) `vagrant init erumble/centos7-x64; vagrant up`
EOF

# do the build
packer build \
  -var "description=${vm_description}" \
  $1

# rollback the README.md if the build fails
if [[ $? != 0 ]]; then
  git checkout -- README.md
fi

