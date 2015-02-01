#!/bin/bash

if [ ! -f ~/.dropbox-dist/dropboxd ]
then
  cd ~
  wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
  cd -
fi
