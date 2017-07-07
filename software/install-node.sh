#!/bin/bash

set -e

# check for root
if [[ "$EUID" -ne 0 ]] ; then
  echo "Please run as root"
  exit
fi

echo ""
echo "============================="
echo "| Setting up Node.js        |"
echo "============================="
echo ""

# https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
#
# curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
# sudo apt-get install -y nodejs

# handle node.js, Nodejs.org only supports ARMv7 with the latest (RPi3)
# however for Pi Zero (ARMv6) you need something else
NODE="$(which nodejs)"

echo "${NODE}"

if [[ -z "${NODE}" ]] ; then
  ARM="$(uname -m)"
  if [[ "$ARM" =~ "7" ]] ; then
    echo " > Detected ARMv7, downloading from nodejs.org"
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    apt-get install -y nodejs
    
    npm install npm@latest -g
    npm install -g httpserver archeyjs
    ./install-archeyjs.sh

  else
    echo " > Detected older ARMv6, please install manually"
    exit 1
  fi
else
  echo ""
  echo "Node already installed!"
  echo ""
fi

echo ""
echo "All done!"
echo ""
