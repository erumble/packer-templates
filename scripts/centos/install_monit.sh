#!/bin/bash -eux
# Purpose - Build and Install Monit from source

VER="5.12.1"
MD5="1ffde79207270925f6f7df787d19100a"

# Install requisite packages 
yum -y install openssl-devel pam-devel 

# make temporary directory to install from
if [[ ! -d ~vagrant/monit-$VER ]]; then
  mkdir -p ~vagrant/monit-$VER
fi

# install monit
pushd ~vagrant/monit-$VER
  wget http://mmonit.com/monit/dist/monit-$VER.tar.gz

  if [[ $(md5sum "monit-$VER.tar.gz") != $MD5* ]]; then
    echo "monit-$VER.tar.gz has an invalid checksum. Aborting."
    exit 1
  fi

  tar -zxvf monit-$VER.tar.gz
  cd monit-$VER
  ./configure --prefix=/usr
  make
  make install

  # copy service script
  cp ./system/startup/rc.monit /etc/rc.d/init.d/monit
  chmod +x /etc/rc.d/init.d/monit
popd

# clean up after ourself
rm -rf ~vagrant/monit-$VER

# create monitrc file and monit.d directory 
mkdir /etc/monit.d

# create monitrc file
cat <<EOT >> /etc/monitrc
# set daemon poll interval to 1 minute
set daemon 60

# set pid file location
set pidfile /var/run/monit.pid

# set id file location
set idfile /var/.monit.id

# set log file location
set logfile /var/log/monit.log
  
# enable web interface
set httpd port 2812 and
  # use address localhost     # only allow localhost
  allow 0.0.0.0/0             # change to restrict incomming connections
  allow admin:monit           # set basic auth

# include all files from /etc/monit.d
include /etc/monit.d/*.conf
EOT

# set monitrc permissions according to monit documentation
chmod 0700 /etc/monitrc 

# enable monit on startup
service monit start
chkconfig monit on

