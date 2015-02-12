#!/bin/bash -eux

VER="2.3.0"

yum install -y wget curl-devel expat-devel gettext openssl-devel zlib-devel perl-devel 

if [[ ! -d ~vagrant/git-$VER ]]; then
  mkdir -p ~vagrant/git-$VER
fi

pushd ~vagrant/git-$VER
  wget https://www.kernel.org/pub/software/scm/git/git-$VER.tar.gz
  tar -zxf git-$VER.tar.gz
  cd git-$VER
  ./configure prefix=/usr
  make 
  make install 
popd

rm -rf ~vagrant/git-$VER

