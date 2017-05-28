#!/bin/bash

set -e

# check if we are root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# save the path of this file
PWD=`pwd`

# python 2/3
PY2_VER=`python --version`
echo ""
echo "============================="
echo "| Setting up ${PY2_VER}     |"
echo "============================="
echo ""
# run as pi?: sudo su - pi -c "commands"
if [[ ! -f "/usr/local/bin/pip" ]]; then
  wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
  # sed '1 c  #!/usr/local/bin/python3' /usr/local/bin/pip3 > test.txt
else
  echo "pip already installed"
fi

# update
# make a function for this?
su pi -c "pip install -U pip wheel setuptools"
su pi -c "pip install -U -r ${PWD}/requirements.txt"

PY3=`which python3`

# check to see if string is empty, meaning python3 not installed
if [[ ! -z "${PY3}" ]]; then
	PY3_VER=`python3 --version`
	echo ""
	echo "============================="
	echo "| Setting up ${PY3_VER}     |"
	echo "============================="
	echo ""
	su pi -c "pip3 install -U pip wheel setuptools"
	su pi -c "pip3 install -U -r ${PWD}/requirements.txt"
fi
