#!/bin/bash

set -e

# check if we are root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

echo ""
echo "============================="
echo "| Setting Up Dotfiles       |"
echo "============================="
echo ""

# link bashrc so I can easily upgrade with a git pull
HOME="/home/pi"
PWD=`pwd`
rm -f ${HOME}/.bashrc
su pi -c "ln -s ${PWD}/static/linux_bashrc ${HOME}/.bashrc"

if [ -f "/etc/profile.d/sshpwd.sh" ]; then
	rm -f /etc/profile.d/sshpwd.sh
else
	echo ""
	echo "*** already removed sshpwd.sh ***"
	echo ""
fi

echo ""
echo "*** $0 Done ***"
echo ""
