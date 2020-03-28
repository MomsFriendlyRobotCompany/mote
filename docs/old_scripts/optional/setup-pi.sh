#!/bin/bash
# Setup a bunch of Pi relevant packages
# sudo: false

if [ $(id -u) = 0 ]; then
  echo "Please run script as a USER"
  exit 1
fi

for pkg in twine numpy RPi.GPIO psutil; do
  pip install -U ${pkg}
done
