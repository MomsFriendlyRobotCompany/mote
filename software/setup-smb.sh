#!/bin/bash
set -e

# check if we are root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

echo ""
echo "============================="
echo "| Setting Up Samba          |"
echo "============================="
echo ""

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
