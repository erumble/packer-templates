#!/bin/bash -eux

VER='2.2.0'
MD5='cd03b28fd0b555970f5c4fd481700852'

# Install requisite packages
yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel \
  make bzip2 autoconf automake libtool bison 

# make a temporary directory to install from
if [[ ! -d ~vagrant/ruby-$VER ]]; then
  mkdir -p ~vagrant/ruby-$VER
fi

# install ruby
pushd ~vagrant/ruby-$VER
  wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-$VER.tar.gz

  if [[ $(md5sum "ruby-$VER.tar.gz") != $MD5* ]]; then
    echo "ruby-$VER.tar.gz has an invalid checksum. Aborting."
    exit 1
  fi

  tar -zxvf ruby-$VER.tar.gz
  cd ruby-$VER
  ./configure prefix=/usr
  make
  make install
popd

# clean up after ourself
rm -rf ~vagrant/ruby-$VER

# install the bundler gem, it's useful
if type -P gem >/dev/null 2>&1; then
  gem update --system
  gem install bundler
else
  echo >&2 "gem is not properly installed. Aborting."
  exit -1
fi

