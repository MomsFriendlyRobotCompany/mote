#!/bin/bash
# ------------------------------
# This is for my roomba robot ... it has little to no application
# outside of what I do with it.
#

pip-upgrade-all() {
    pip list --outdated | cut -d' ' -f1 | xargs pip install --upgrade
}

set -e

# check if we are root
if [ "$EUID" -ne 0 ] ; then
  echo "Please run as root"
  exit 1
fi

# create users
adduser mday
adduser tday

# allow users to mount rpi using samba
smbpasswd -a mday
smbpasswd -a tday

# pi is a member of these groups
# pi adm dialout cdrom sudo audio video plugdev games users input netdev gpio i2c spi

# add users to staff group
# usermod -a -G group1,group2,group3 exampleusername
usermod -a -G staff mday
usermod -a -G staff tday
