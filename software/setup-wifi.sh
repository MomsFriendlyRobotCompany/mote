#!/bin/bash

set -e

# check if we are root
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit 1
fi

# need to pass in SSID and password
if [[ $# -ne 2 ]] ; then
	echo ""
	echo "Please supply 2 args: SSID and PASSWORD"
	echo ""
	exit 1
fi

echo ""
echo "============================="
echo "| Setting Up WiFi           |"
echo "============================="
echo ""

SSID=$1
PASSWORD=$2
PSK=`wpa_passphrase ${SSID} ${PASSWORD} | grep psk | awk '!/#/'`

# split the string on '='
IFS='=' read -a myarray <<< "${PSK}"

HASH="${myarray[1]}"

INFO="\n\
network={ \n\
    ssid=\"${SSID}\" \n\
    key_mgmt=WPA-PSK \n\
    proto=WPA2 \n\
    psk=\"${HASH}\" \n\
} \n"

echo -e "${INFO}" >> /etc/wpa_supplicant/wpa_supplicant.conf

echo "Network should be successfully added"
echo ""
cat /etc/wpa_supplicant/wpa_supplicant.conf
