#!/bin/bash
set -e

# check if we are root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
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
if [ ! -d "/home/pi/.ssh" ]; then
  su - pi -c "ssh-keygen -q -N "" -f ~/.ssh/id_rsa -t rsa"
else
  echo "ssh already setup"
fi

# create temp and git folder
su - pi -c "mkdir -p ~/tmp"
su - pi -c "mkdir -p ~/github"
su - pi -c "mkdir -p ~/bitbucket"

# samba setup
if [ ! -f "/etc/samba/smb.bak" ]; then
  mv /etc/samba/smb.conf /etc/samba/smb.bak
  cp smb.conf /etc/samba
  smbpasswd -a pi
  service smbd restart
  service nmbd restart
else
  echo "samba already set up"
fi

# commandline setup
if [ ! -d "/home/pi/github/dotfiles" ]; then
  su - pi -c "cd ~/github && git clone http://github.com/walchko/dotfiles.git"
  su - pi -c "cd ~/github/dotfiles && ./linux-setup.sh"
else
  echo "git repo dotfiles already cloned"
fi

# if [ -f "/etc/profile.d/sshpwd.sh" ]; then
#   rm -f /etc/profile.d/sshpwd.sh
# else
#   echo "already removed sshpwd.sh"
# fi
# 
# if [ ! -f "/etc/profile.d/motd.sh" ]; then
#   ln -s /home/pi/github/mote/software/motd /etc/profile.d/motd.sh
# else
#   echo "already setup motd.sh"
# fi

# just in case root changed a permission in ~
chown -R pi:pi /home/pi

echo ""
echo "============================="
echo "| Need to reboot now        |"
echo "============================="
echo ""
