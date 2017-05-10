#!/bin/bash

set -e

# check if we are root
if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root"
  exit 1
fi

# make sure hostinfo is up to date
su - pi -c "npm install -g archeyjs"

# create link
if [ ! -f "/etc/systemd/system/archeyjs.service" ]; then
  #ln -s `pwd`/hostinfo.service /etc/systemd/system/hostinfo.service
  cp archeyjs.service /etc/systemd/system/
else
  echo "archeyjs already set up"
fi

# update and start
systemctl enable archeyjs
service archeyjs start
