#!/bin/bash -eux

VER="2.1.2"

yum install -y wget curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-ExtUtils-MakeMaker

if [[ ! -d ~vagrant/git-$VER ]]; then
  mkdir -p ~vagrant/git-$VER
fi

pushd ~vagrant/git-$VER
  wget https://www.kernel.org/pub/software/scm/git/git-$VER.tar.gz
  tar -zxf git-$VER.tar.gz
  cd git-$VER
  make prefix=/usr/local all
  make prefix=/usr/local install
popd

rm -rf ~vagrant/git-$VER

