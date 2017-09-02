#!/bin/bash

set -e

# check if we are root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

echo ""
echo "============================="
echo "| Setting Up /etc/motd      |"
echo "============================="
echo ""

rm -f /etc/motd
touch /etc/motd

# if something is there, delete it and redo
if [ -f "/etc/profile.d/motd.sh" ]; then
	rm -f /etc/profile.d/motd.sh
fi

PWD=`pwd`
ln -s ${PWD}/static/motd /etc/profile.d/motd.sh

echo ""
echo "*** Done ***"
echo ""
