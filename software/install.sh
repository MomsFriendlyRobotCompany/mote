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

# linux kernel
apt-get -y install raspi-config rpi-update

# bluetooth
apt-get -y install bluez libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev

# ascii art
apt-get -y install jp2a figlet

# get updated packages
# curl -s https://packagecloud.io/install/repositories/walchko/robots/script.deb.sh | sudo bash
# apt-get update
# apt-get -y install python3k
# dpkg -i python3k libopencv3 zeromq-kevin

# install node.js
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
apt-get install -y nodejs
npm install -g httpserver

# python 2/3
# run as pi?: sudo su - pi -c "commands"
cd ~/tmp && wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
su - pi -c "pip install -U pip wheel setuptools"
pip install -U -r requirements.txt

pip3 install -U pip wheel setuptools
pip3 install -U -r requirements.txt

# update kernel
rpi-update




echo ""
echo "============================="
echo "| Done !!! :)               |"
echo "============================="
echo ""
