#!/bin/bash

sudo apt-get install -y pidgin


# hipster chat
FILE=/etc/apt/sources.list.d/atlassian-hipchat.list
if [ ! -f $FILE ]
then
  echo "deb http://downloads.hipchat.com/linux/apt stable main" | sudo tee -a $FILE
  sudo apt-get update
  wget -O - https://www.hipchat.com/keys/hipchat-linux.key | sudo apt-key add -
  sudo apt-get update
fi
sudo apt-get install -y hipchat