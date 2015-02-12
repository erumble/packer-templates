#!/bin/bash -eux

VER='2.2.0'

yum groupinstall -y "Development Tools"
yum install -y openssl-devel

if [[ ! -d ~vagrant/ruby-$VER ]]; then
  mkdir -p ~vagrant/ruby-$VER
fi

pushd ~vagrant/ruby-$VER
  wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-$VER.tar.gz
  tar -xzf ruby-$VER.tar.gz
  cd ruby-$VER
  ./configure prefix=/usr
  make
  make install
popd

rm -rf ~vagrant/ruby-$VER

if type -P gem >/dev/null 2>&1; then
  gem update --system
  gem install bundler
else
  echo >&2 "gem is not properly installed. Aborting."
  exit -1
fi

