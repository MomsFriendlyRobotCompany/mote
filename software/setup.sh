#!/bin/bash
set -e

USEAGE="setup.sh <HOSTNAME> <WIFI-SSID> <WIFI-PASSWORD>"

# check if we are root
if [ "$EUID" -ne 0 ] ; then
  echo "Please run as root"
  exit 1
fi

if [[ $# -ne 3 ]] ; then
  echo "Please supply a hostname"
  echo $USEAGE
  exit 1
fi

# configure -----------------------------------------
./setup-raspi-config.sh

# create temp and git folder
mkdir -p ~/tmp

# commandline setup
./setup-dotfiles.sh $1

# setup wifi
./setup-wifi.sh $2 $3

# just in case root changed a permission in ~
chown -R pi:pi /home/pi
chown -R pi:pi /usr/local

echo ""
echo "============================="
echo "| Need to reboot now        |"
echo "============================="
echo ""
