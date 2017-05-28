#!/bin/bash

# check for root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

RETURN=`pwd`

echo ""
echo "============================="
echo "| Let's get some pkgs       |"
echo "============================="
echo ""

HOME='/home/pi'

if [[ -f "${HOME}/github/raspbian_pkgs" ]]; then
	echo ""
	echo "Looks like you are good to go!"
	echo ""
else
	cd ${HOME}/github
	git clone https://github.com/walchko/raspbian_pkgs.git
	cd raspbian_pkgs/debian_packages
	dpkg -i libopencv3-kevin.deb
	dpkg -i python3-kevin.deb
	dpkg -i zeromq-kevin.deb

	# handle node.js, Nodejs.org only supports ARMv7 with the latest (RPi3)
	# however for Pi Zero (ARMv6) you need something else
	NODE=`which node`

	if [[ -z "${NODE}" ]]; then
		ARM=`uname -m`
		if [[ "$ARM" =~ "7" ]]; then
			curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
			apt-get install -y nodejs
			npm install npm@latest -g
			npm install -g httpserver archeyjs
		else
			dpkg -i node-armv6.deb
			npm install npm@latest -g
			npm install -g httpserver archeyjs
		fi

		echo ""
		echo "All done!"
		echo ""
	fi
fi
