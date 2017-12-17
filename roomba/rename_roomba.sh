#!/bin/bash
# ----------------------------------------------------------
# this will rename a gold master roomba from the default name
# of gold to the first argument. It will also correctthe SSID
# name of the access point on wlan0 to this provided hostname
#

set -e

# check if we are root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
	exit 1
fi

if [[ $# -eq 0 ]]; then
  echo "-----------------------------------------"
  echo "Please supply a hostname"
  echo "-----------------------------------------"
  exit 1
fi

echo ""
echo "+-------------------------+"
echo "| Setting up Roomba       |"
echo "+-------------------------+"
echo ""


# set hostname --------------------------------------
HOSTNAME=$1
raspi-config nonint do_hostname ${HOSTNAME}

# install python libraries --------------------------
# pip install -U -r roomba.txt

# set SSID on wifi ----------------------------------
# note: SSID will be set too hostname
OLD_NAME=`uname -n`
if [[ -f "/etc/hostapd/hostapd.conf" ]]; then
  sed -i -e "s/${OLD_NAME}/${HOSTNAME}/g" /etc/hostapd/hostapd.conf
else
  echo "*** ERROR: access point NOT setup ***"
  echo "*** /etc/hostapd/hostapd.conf does NOT exit ***"
  exit 1
fi

echo "***********************"
echo " $0 Done "
echo "***********************"
