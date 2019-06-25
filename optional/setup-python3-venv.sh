#!/bin/bash

set -e

# check if we are root
if [ "$EUID" -eq 0 ]
  then echo "Please run as USER"
  exit 1
fi

sudo apt-get install python3-venv python3-dev -y

python3 -m venv /home/pi/.venv

source /home/pi/.venv/bin/activate

pip install -U pip setuptools wheel
pip install numpy requests nose msgpack pyzmq twine
