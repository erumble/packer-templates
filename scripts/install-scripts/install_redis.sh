#!/usr/bin/env bash
#
# Install Redis and configure it according to
# http://redis.io/topics/quickstart

VER='stable'
MD5='4d8e3fc6eb0f94151f65d22c6d35d41d'

# make a temporary directory to install from
if [[ ! -d ~vagrant/redis-$VER ]]; then
  mkdir -p ~vagrant/redis-$VER
fi

# install redis
pushd ~vagrant/redis-$VER
  wget http://download.redis.io/redis-stable.tar.gz
  
  if [[ $(md5sum "redis-$VER.tar.gz") != $MD5* ]]; then
    echo "redis-$VER.tar.gz has an invalid checksum. Aborting."
    exit 1
  fi

  tar -zxvf redis-$VER.tar.gz
  cd redis-$VER
  ./configure prefix=/usr
  make
  make install

  # create directories for config files and data
  mkdir /etc/redis
  mkdir -p /var/redis/6379

  # copy the init script
  cp utils/redis_init_script /etc/init.d/redis

  # copy the config file and set a few things
  cp redis.conf /etc/redis/6379.conf
  sed -i 's/daemonize no/daemonize yes/' /etc/redis/6379.conf
  sed -i 's/pidfile \/var\/run\/redis\.pid/pidfile \/var\/run\/redis_6379\.pid/' /etc/redis/6379.conf
  sed -i 's/logfile ""/logfile \/var\/log\/redis_6379\.pid/' /etc/redis/6379.conf
  sed -i 's/dir \.\//dir \/var\/redis\/6379/' /etc/redis/6379.conf
popd

# clean up after ourself
rm -rf ~vagrant/redis-$VER

# configure redis to start on startup
service redis start
chkconfig redis on

