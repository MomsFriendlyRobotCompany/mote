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

apt-get update
apt-get upgrade -y
apt-get autoremove -y

echo ""
echo "============================="
echo "| Let's install some pkgs   |"
echo "============================="
echo ""


