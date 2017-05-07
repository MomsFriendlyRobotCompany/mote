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
apt-get -y install cmake pkg-config build-essential git python-dev swig

# admin
apt-get -y install nmap htop samba samba-common-bin arp-scan wget curl libpcap0.8-dev

# linux kernel
apt-get -y install raspi-config rpi-update

# numpy
# need atlas | blas | f2py | fortran
apt-get -y install libatlas-base-dev gfortran

# bluetooth
apt-get -y install bluez libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev

# ascii art
apt-get -y install jp2a figlet

# get updated packages
if [[ ! -d "/etc/apt/sources.list.d/walchko_robots.list" ]]; then
  curl -s https://packagecloud.io/install/repositories/walchko/robots/script.deb.sh | sudo bash
  apt-get update
  # apt-get -y install python3k zeromq-kevin
  # dpkg -i python3k libopencv3 zeromq-kevin
else
  echo "packagecloud is already setup"
fi

apt-get -y install python3k zeromq-kevin

# install node.js
#curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash - 
#apt-get install -y nodejs
#npm install -g httpserver

# python 2/3
# run as pi?: sudo su - pi -c "commands"
if [[ ! -f "/usr/local/bin/pip" ]]; then
  wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
  #su - pi -c "pip install -U pip wheel setuptools"
  #su - pi -c "pip install -U -r requirements.txt"
  # sed '1 c  #!/usr/local/bin/python3' /usr/local/bin/pip3 > test.txt
else
  echo "pip already installed"
fi

# make a function for this?
su - pi -c "pip install -U pip wheel setuptools"
# su - pi -c "pip install -U -r /home/pi/github/mote/software/requirements.txt"
su - pi -c "python3 -m pip install -U pip wheel setuptools"
# su - pi -c "python3 -m pip install -U -r /home/pi/github/mote/software/requirements.txt"
# pip install -U pip wheel setuptools
# pip install -U -r /home/pi/github/mote/software/requirements.txt
# pip3 install -U pip wheel setuptools
# pip3 install -U -r /home/pi/github/mote/software/requirements.txt

# update kernel
rpi-update

# fix permissions
chown -R pi:pi /usr/local


echo ""
echo "============================="
echo "| Done !!! :)               |"
echo "============================="
echo ""
