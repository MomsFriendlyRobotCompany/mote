#!/bin/bash
set -e

USEAGE="setup.sh <HOSTNAME>"

# check if we are root
if [ "$EUID" -ne 0 ] ; then
  echo "Please run as root"
  exit 1
fi

if [[ $# -ne 1 ]] ; then
  echo "Please supply a hostname"
  echo $USEAGE
  exit 1
fi

# configure -----------------------------------------
./setup-raspi-config.sh

# create temp folder
mkdir -p ~/tmp

# commandline setup
./setup-dotfiles.sh

# message of the day
./setup-motd.sh

# setup wifi
# ./setup-wifi.sh $2 $3
./setup-access-point.sh

# just in case root changed a permission in ~
chown -R pi:pi /home/pi
chown -R pi:pi /usr/local

echo ""
echo "============================="
echo "| Need to reboot now        |"
echo "============================="
echo ""
