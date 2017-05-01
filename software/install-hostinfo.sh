#!/bin/bash

set -e

# check if we are root
if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root"
  exit 1
fi

# create link
if [ ! -f "/etc/systemd/system/hostinfo.service" ]; then
  ln -s `pwd`/hostinfo.service /etc/systemd/system/hostinfo.service
else
  echo "hostinfo already set up"
fi

# update and start
systemctl enable hostinfo
service hostinfo start
