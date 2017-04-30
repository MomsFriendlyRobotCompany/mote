#!/bin/bash

# check for root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

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
apt-get -y install cmake pkg-config build-essential git libpcap0.8-dev

# admin
apt-get -y install nmap htop samba samba-common-bin arp-scan wget curl
apt-get -y install figlet

# linux kernel
apt-get -y install raspi-config rpi-update

# ascii art
apt-get -y install jp2a

# install node.js
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
apt-get install -y nodejs
npm install -g httpserver

echo ""
echo "============================="
echo "| Done !!! :)               |"
echo "============================="
echo ""
