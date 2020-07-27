#!/bin/bash

# check for root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

RETURN=`pwd`

echo ""
echo "============================="
echo "| Let's update some pkgs    |"
echo "============================="
echo ""

# update
apt-get update
apt-get -y upgrade

echo ""
echo "============================="
echo "| Let's install some pkgs   |"
echo "============================="
echo ""

# programming
apt-get -y install cmake pkg-config build-essential git swig

# misc
apt-get -y install i2c-tools

# admin
apt-get -y install nmap htop samba samba-common-bin arp-scan wget curl
apt-get -y install wavemon libpcap0.8-dev

# linux kernel
apt-get -y install raspi-config rpi-update

# moved to install-python.sh
# numpy
# need atlas | blas | f2py | fortran
# apt-get -y install libatlas-base-dev gfortran
#
# python3
# apt-get -y install libmpdec2
# apt-get -y install python3

# bluetooth
apt-get -y install bluez libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev

# ascii art
apt-get -y install jp2a figlet

# python package lxml is a BITCH ... it NEVER updates nicely, so you need these
# http://lxml.de/installation.html
apt-get -y install libxml2-dev libxslt-dev python-dev

# node - this ONLY works on RPi 3 (ARMv7) ... it will warn you if ARMv6
./install-node.sh
./install-archeyjs.sh

# python 2/3
#./install-python.sh

# update kernel
rpi-update

# fix permissions
chown -R pi:pi /usr/local


echo ""
echo "============================="
echo "| Done !!! :)               |"
echo "|                           |"
echo "| Rebooting NOW !!!!!!!!    |"
echo "============================="
echo ""

reboot now
