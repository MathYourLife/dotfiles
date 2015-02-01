#!/bin/bash

sudo apt-get install -y zlib1g-dev libxml2-dev libxslt1-dev libssl-dev libreadline-dev

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -d ~/.rbenv ]
then
  cd ~/.rbenv && git pull && cd -
else
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
fi

if [ -d ~/.rbenv/plugins/ruby-build ]
then
  cd ~/.rbenv/plugins/ruby-build && git pull && cd -
else
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# Link to the git repo version
if [ ! -h ~/.chefenv ]
then
  ln -s $DIR/chefenv ~/.chefenv
  exec $SHELL -l
fi


if [ ! -d ~/.rbenv/versions/1.9.3-p484 ]
then
  rbenv install 1.9.3-p484
fi

if [ ! "$(rbenv global)" == "1.9.3-p484" ]
then
  rbenv global 1.9.3-p484
fi

sudo apt-get install -y dkms
HAS_KEY=$(sudo apt-key list | grep -c 'VirtualBox archive signing key')

if [ "$HAS_KEY" == "0" ]
then
  wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
fi

PKG_SRC=$(grep -c 'http://download.virtualbox.org/virtualbox/debian' /etc/apt/sources.list.d/virtualbox.list)
if [ "$PKG_SRC" == "0" ]
then
  sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian raring contrib" >> /etc/apt/sources.list.d/virtualbox.list'
  sudo apt-get update
fi
sudo apt-get install -y virtualbox-4.3

HAS_VAGRANT=$(dpkg --get-selections | grep -cP 'vagrant\s*install')
if [ "$HAS_VAGRANT" == "0" ]
then
  echo "install vagrant"
  rm -f ~/tmp/vagrant_1.3.5_x86_64.deb
  wget -P ~/tmp http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/vagrant_1.3.5_x86_64.deb
  sudo dpkg -i ~/tmp/vagrant_1.3.5_x86_64.deb
fi

if [ "$(vagrant plugin list | grep -c vagrant-berkshelf)" == "0" ]
then
  sudo vagrant plugin install vagrant-berkshelf
fi

if [ "$(vagrant plugin list | grep -c vagrant-omnibus)" == "0" ]
then
  sudo vagrant plugin install vagrant-omnibus
fi

if [ "$(vagrant plugin list | grep -c vagrant-chef-zero)" == "0" ]
then
  sudo vagrant plugin install vagrant-chef-zero
fi

mkdir -p ~/work/cookbooks
mkdir -p ~/git/dyn/cookbooks
if [ -d ~/work/cookbooks/dyn_chef_data ]
then
  cd ~/work/cookbooks/dyn_chef_data && git pull origin master && cd -
else
  git clone git@github.corp.dyndns.com:DevTools/dyn_chef_data.git ~/git/dyn/cookbooks/dyn_chef_data
  ln -s ~/git/dyn/cookbooks/dyn_chef_data ~/work/cookbooks/dyn_chef_data
  cd ~/work/cookbooks/dyn_chef_data
  gem install bundler --no-ri --no-rdoc
  rbenv rehash
  bundle
  rbenv rehash
  cd -
fi

mkdir -p ~/git/dyn/DevTools
if [ -d ~/.chef ]
then
  cd ~/git/dyn/DevTools/knife-config && git pull origin master && cd -
else
  git clone git@github.corp.dyndns.com:DevTools/knife-config.git ~/git/dyn/DevTools/knife-config
  ln -s ~/git/dyn/DevTools/knife-config ~/.chef
  cd ~/.chef
  git submodule init
  git submodule update
  ln -s ~/work/cookbooks/dyn_chef_data/plugins/ plugins
  cd -
fi

