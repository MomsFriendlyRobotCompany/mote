#!/bin/bash

set -e

# check if we are root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

setup_pip(){
  PIP=$1
  PYTHON=$2
  PY_VER=$(${PYTHON} --version 2>&1)
  echo ""
  echo "============================="
  echo "| Setting up ${PY_VER}     |"
  echo "============================="
  echo ""
  # run as pi?: sudo su - pi -c "commands"
  if [[ ! -f "/usr/local/bin/${PIP}" ]]; then
    wget https://bootstrap.pypa.io/get-pip.py && ${PYTHON} get-pip.py
  else
    echo "${PIP} already installed"
  fi
  
  ${PIP} install -U pip wheel setuptools
}

# save the path of this file
PWD=`pwd`


# install python 2/3
apt-get -y install build-essential cmake pkg-config swig
apt-get -y install libmpdec2
apt-get -y install python-dev
apt-get -y install python3 python3-dev

# get rid of any pip package crap
apt-get -y remove --purge python-pip python-pip-whl python3-pip
apt-get autoremove

# numpy
# need atlas | blas | f2py | fortran
apt-get -y install libatlas-base-dev gfortran

# python 2/3
# note python outputs verison to STDERR, need to redirect to STDOUT
# PY2_VER=$(python --version 2>&1)
# echo ""
# echo "============================="
# echo "| Setting up ${PY2_VER}     |"
# echo "============================="
# echo ""
# # run as pi?: sudo su - pi -c "commands"
# if [[ ! -f "/usr/local/bin/pip" ]]; then
#   wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
#   # sed '1 c  #!/usr/local/bin/python3' /usr/local/bin/pip3 > test.txt
# else
#   echo "pip already installed"
# fi

# update
# # make a function for this?
# pip install -U pip wheel setuptools
# pip install -U -r ${PWD}/static/requirements.txt

# check to see if string is empty, meaning python3 not installed
# if [[ ! -f "/usr/local/bin/pip3" ]]; then
# 	PY3_VER=$(python3 --version 2>&1)
# 	echo ""
# 	echo "============================="
# 	echo "| Setting up ${PY3_VER}     |"
# 	echo "============================="
# 	echo ""
# 	if [[ -f "/usr/local/bin/pip3" ]]; then
# 	  echo "*** you already have pip3 installed ***"
# 	else
# 	  python3 get-pip.py
# 	fi
# 	pip3 install -U pip wheel setuptools
# 	pip3 install -U -r ${PWD}/static/requirements.txt
# else
# 	echo ""
# 	echo "*** No Python3 detected ***"
# 	echo ""
# fi

setup_pip pip python
# pip install -U -r ${PWD}/static/requirements.txt

setup_pip pip3 python3
# pip3 install -U -r ${PWD}/static/requirements.txt

# fix permissions
chown -R pi:pi /usr/local
chown -R pi:pi /usr/lib/python2.7/dist-packages
chown -R pi:pi /usr/lib/python3/dist-packages
