#!/bin/bash
# ------------------------------
# This is for my roomba robot ... it has little to no application
# outside of what I do with it.
#

pip-upgrade-all() {
    pip list --outdated | cut -d' ' -f1 | xargs pip install --upgrade
}

pip3-upgrade-all() {
    pip3 list --outdated | cut -d' ' -f1 | xargs pip3 install --upgrade
}

set -e

USEAGE="setup.sh <HOSTNAME>"

# check if we are root
if [ "$EUID" -ne 0 ] ; then
  echo "Please run as root"
  exit 1
fi

if [[ $# -ne 1 ]] ; then
  echo "Please supply a hostname"
  echo $USEAGE
  exit 1
fi

# configure -----------------------------------------
./setup-raspi-config.sh

# create temp folder
mkdir -p /home/pi/tmp

# commandline setup
./setup-dotfiles.sh

# message of the day
./setup-motd.sh

# setup access point with default wlan0
./setup-access-point.sh

# double check everything is updated
pip install -U pip setuptools wheel
pip3 install -U pip setuptools wheel

pip-upgrade-all
pip3-upgrade-all

# install roomba specific stuff
PYLIBS="opencvutils build_utils numpy nose pycreate2 \
future sparklines simplejson nxp_imu ins_nav pyurg ar_markers \
pyserial pyhexdump the-collector"

pip install -U ${PYLIBS}

# just in case root changed a permission in ~
chown -R pi:pi /home/pi
chown -R pi:pi /usr/local

echo ""
echo "============================="
echo "| Need to reboot now        |"
echo "============================="
echo ""
