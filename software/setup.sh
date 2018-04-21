#!/bin/bash
set -e

USEAGE="setup.sh <HOSTNAME>"

# check if we are root
if [ "$EUID" -ne 0 ] ; then
  echo "Please run as root"
  exit 1
fi

if [[ $# -ne 2 ]] ; then
  echo "Please supply a hostname"
  echo $USEAGE
  exit 1
fi

# configure -----------------------------------------
./setup-raspi-config.sh $1

# create temp and git folder
mkdir -p ~/tmp

# commandline setup
./setup-dotfiles.sh $1

# message of the day
./setup-motd.sh

# setup wifi - this is done elsewhere now
#./setup-wifi.sh $2 $3

# just in case root changed a permission in ~
chown -R pi:pi /home/pi
chown -R pi:pi /usr/local
chown -R pi:pi /usr/lib/python2.7

echo ""
echo "============================="
echo "| Need to reboot now        |"
echo "============================="
echo ""
