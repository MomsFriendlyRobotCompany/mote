#!/bin/bash

set -e

# check if we are root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

if [[ $# -eq 0 ]] ; then
  echo "$0: Please supply a hostname"
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

echo ""
echo "*** $0 Done ***"
echo ""
