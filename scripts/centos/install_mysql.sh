#!/bin/bash -eux

yum localinstall -y http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
yum install -y mysql-community-server mysql-community-devel
service mysqld start
chkconfig --levels 235 mysqld on

