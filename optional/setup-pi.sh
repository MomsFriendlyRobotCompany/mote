#!/bin/bash

if [ $(id -u) = 0 ]; then
  echo "Please run script as a USER"
  exit 1
fi

for pkg in twine numpy RPi.GPIO psutil netifaces nose requests; do
  pip install -U ${pkg}
done
