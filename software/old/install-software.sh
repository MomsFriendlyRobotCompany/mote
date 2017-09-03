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

echo ""
echo "*** fixing apt sources ***"
echo ""

sh -c 'echo "deb http://www.deb-multimedia.org jessie main" >> /etc/apt/sources.list'

echo ""
echo "*** updating apt-get and installing ffmpeg ***"
echo ""
apt-get update
apt-get -y install deb-multimedia-keyring
apt-get -y install ffmpeg

HOME='/home/pi'

if [[ -f "${HOME}/github/raspbian_pkgs" ]]; then
	echo ""
	echo "Looks like you are good to go!"
	echo ""
else
	cd ${HOME}/github
	git clone https://github.com/walchko/raspbian_pkgs.git
	cd raspbian_pkgs/debian_packages

	echo ""
	echo " *** install OpenCV ***"
	echo ""
	dpkg -i libopencv3-kevin.deb
	sudo apt-get -y -f install
	dpkg -i libopencv3-kevin.deb

	echo ""
	echo " *** install Python3 ***"
	echo ""
	dpkg -i python3-kevin.deb

	echo ""
	echo " *** fix pip3 ***"
	echo ""
	cd ${RETURN}
	rm -f /usr/local/bin/pip3
	cp static/pip3 /usr/local/bin

	echo ""
	echo " *** install ZeroMQ ***"
	echo ""
	dpkg -i zeromq-kevin.deb

	# handle node.js, Nodejs.org only supports ARMv7 with the latest (RPi3)
	# however for Pi Zero (ARMv6) you need something else
	NODE=`which nodejs`

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
