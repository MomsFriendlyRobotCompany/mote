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

# constants -----------------------------------------
# 0 - on
# 1 - off
ON=0
OFF=1

# set these -----------------------------------------
HOSTNAME=$1
GPUMEMORY=16
WIFI=US

# config system --------------------------------------
raspi-config nonint do_hostname $HOSTNAME
raspi-config nonint do_i2c $ON
raspi-config nonint do_spi $ON
raspi-config nonint do_wifi_country $WIFI
raspi-config nonint do_camera $ON
raspi-config nonint do_memory_split $GPUMEMORY

# setup ----------------------------------------------
# create keys, quiet, empty pass phrase
./setup-ssh.sh

# create temp and git folder
su - pi -c "mkdir -p ~/tmp"
# su - pi -c "mkdir -p ~/github"  # you are probably already running from here :P
# su - pi -c "mkdir -p ~/bitbucket"

# # samba setup
./setup-smb.sh

# commandline setup
./setup-dotfiles.sh

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
