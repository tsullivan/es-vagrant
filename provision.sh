#!/usr/bin/env bash

# Allow installation of PPAs and update packages
apt-get update
apt-get upgrade
apt-get install -y python-software-properties

# Set the time zone
echo "America/Phoenix" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

# Automated install of Oracle Java
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get install -y oracle-java8-installer

# Install golang, optional
#add-apt-repository -y ppa:duh/golang
#apt-get update
#apt-get install -y golang

# Install utils
apt-get install -y git curl unzip screen
# Install build tools (required for bcrypt)
apt-get install -y make build-essential python2.7
# Install node via nave
# git clone https://github.com/isaacs/nave.git
# ./nave/nave.sh usemain 4.2.3
# Install node via nodesource
curl -sL https://deb.nodesource.com/setup_0.12 | bash -
apt-get install -y nodejs
# Install esvm
npm install --unsafe-perm -g esvm@^3.1.0

# Make elasticsearch not choke
echo "#### Elasticserch settings" >> /etc/security/limits.conf
echo "* soft nproc 65535" >> /etc/security/limits.conf
echo "* hard nproc 65535" >> /etc/security/limits.conf
echo "* soft nofile 65535" >> /etc/security/limits.conf
echo "* hard nofile 65535" >> /etc/security/limits.conf
echo "* soft memlock unlimited" >> /etc/security/limits.conf
echo "* hard memlock unlimited" >> /etc/security/limits.conf
ulimit -n 65535
ulimit -l unlimited

echo "ElasticSearch is not running, SSH in to start it. esvm.rc is in /vagrant"
