#!/bin/bash
set -e

USEAGE="setup.sh <HOSTNAME>"

# check if we are root
if [ "$EUID" -ne 0 ] ; then
  echo "Please run as root"
  exit 1
fi

if [[ $# -ne 1 ]] ; then
  echo "Please supply a hostname"
  echo $USEAGE
  exit 1
fi

# change hostname - need to reboot
hostnamectl set-hostname $1

# change user password from default
echo -e "ubuntu\nbear321\nbear321" | passwd ubuntu

# stop x windows from starting at boot
systemctl disable lightdm

# stop magni-base from starting ... wrong robot
systemctl disable magni-base

echo ""
echo "============================="
echo "| Need to reboot now        |"
echo "============================="
echo ""
