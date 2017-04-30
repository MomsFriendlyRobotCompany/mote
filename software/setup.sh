#!/bin/bash
set -e

# check if we are root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [[ $# -eq 0 ]] ; then
	echo "Please supply a hostname"
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
# ssh-keygen -q -N "" -f ~/.ssh/id_rsa -t rsa

# create temp and git folder
mkdir -p ~/tmp
mkdir -p ~/github
mkdir -p ~/bitbucket

# samba setup
mv /etc/samba/smb.conf /etc/samba/smb.bak
cp smb.conf /etc/samba
sudo smbpasswd -a pi
sudo service smbd restart
sudo service nmbd restart

# commandline setup
# change to pi
if [ ! -d "~/github/dotfiles" ]; then
	su - pi -c "cd ~/github && git clone http://github.com/walchko/dotfiles.git"
	su - pi -c "cd ~/github/dotfiles && ./linux-setup.sh"
fi

echo ""
echo "============================="
echo "| Need to reboot now        |"
echo "============================="
echo ""
