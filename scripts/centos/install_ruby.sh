#!/bin/bash -eux

yum groupinstall -y "Development Tools"
yum install -y openssl-devel

mkdir ruby-cache
pushd ./ruby-cache
  wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz
  tar -xzf ruby-2.1.2.tar.gz
  cd ruby-2.1.2
  ./configure
  make
  make install
popd

rm -rf ./ruby-cache

echo 'export PATH=$PATH:/usr/local/bin' > ~root/.bash_profile
source ~root/.bash_profile

if type -P gem >/dev/null 2>&1; then
  gem update --system
  gem install bundler
else
  echo >&2 "gem is not properly installed. Aborting."
  exit -1
fi

