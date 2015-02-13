#!/bin/bash -eux

VER="2.3.0"
MD5="edf994cf34cd3354dadcdfa6b4292335"

# Install requisite packages
yum install -y wget curl-devel expat-devel gettext openssl-devel zlib-devel perl-devel 

# make a temporary directory to install from
if [[ ! -d ~vagrant/git-$VER ]]; then
  mkdir -p ~vagrant/git-$VER
fi

# install git
pushd ~vagrant/git-$VER
  wget https://www.kernel.org/pub/software/scm/git/git-$VER.tar.gz

  if [[ $(md5sum "git-$VER.tar.gz") != $MD5* ]]; then
    echo "git-$VER.tar.gz has an invalid checksum. Aborting."
    exit 1
  fi
  
  tar -zxf git-$VER.tar.gz
  cd git-$VER
  ./configure prefix=/usr
  make 
  make install 
popd

# clean up after ourself
rm -rf ~vagrant/git-$VER

