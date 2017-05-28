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

PWD=`/home/pi`

# commandline setup
if [ ! -d "${PWD}/github/dotfiles" ]; then
  su pi -c "cd ${PWD}/github && git clone http://github.com/walchko/dotfiles.git"
  su pi -c "cd ${PWD}/github/dotfiles && ./linux-setup.sh"
else
  echo "git repo dotfiles already cloned"
  su pi -c "cd ${PWD}/github/dotfiles && git pull"
fi
