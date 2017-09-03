#!/bin/bash

set -e

# check if we are root
if [ "$EUID" -ne 0 ]; then
  echo "*** Please run as root ***"
  exit 1
fi

# setup pip
# setup_pip [pip_ver] [python_ver]
#   setup_pip pip3 python3
setup_pip(){
  PIP=$1
  PYTHON=$2
  # note python outputs verison to STDERR, need to redirect to STDOUT
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
setup_pip pip python
# pip install -U -r ${PWD}/static/requirements.txt

setup_pip pip3 python3
# pip3 install -U -r ${PWD}/static/requirements.txt

# fix permissions
chown -R pi:pi /usr/local
chown -R pi:pi /usr/lib/python2.7/dist-packages
chown -R pi:pi /usr/lib/python3/dist-packages
