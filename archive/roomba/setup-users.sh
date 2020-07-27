#!/bin/bash
# ------------------------------
# This is for my roomba robot ... it has little to no application
# outside of what I do with it.
#

pip-upgrade-all() {
    pip list --outdated | cut -d' ' -f1 | xargs pip install --upgrade
}

setup-ssh(){
  USR=$1
  HOME="/home/${USR}"

  if [ ! -f "${HOME}/.ssh/id_rsa" ]; then
    # su - ... the - give you a login env, so ~ should work
    # -c executes a command
  	su - ${USR} -c "ssh-keygen -q -N \"\" -f ~/.ssh/id_rsa -t rsa"
  else
  	echo ""
  	echo "ssh already setup"
  fi

  su - ${USR} -c "ssh-keygen -lvf ~/.ssh/id_rsa.pub"
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
#
# add users to groups
#
# pi       User-specific group. A group is automatically created for
#          each new user; you can ignore this.
# adm      Allows access to log files in /var/log and using xconsole
# dialout  Allows access to serial ports/modem reconfiguration, etc.
# cdrom    Uncreatively, this group enables access to optical drives.
# sudo     Enables sudo access for the user.
# audio    Allows access to audio devices like microphones and soundcards
# video    Allows graphics card/webcam access.
# plugdev  Enables access to external storage devices
# games    I’m unsure of this. No files belong to this group by default,
#          and I cannot find references to it online.
# users    Appears to be a Pi-specific group enabling access to
#          /opt/vc/src/hello_pi/ directory and contained files.
# input    Appears to give access to the /dev/input/mice folder and nothing else.
# netdev   Enables access to network interfaces
# gpio     Pi-specific group for GPIO pin access.
# i2c      Similar to the above, but for I2C access.
#          Generated after installing i2c-tools.
# spi      Similar to the above, but for the SPI bus.
#
# to check: groups <username>
#
# usermod -a -G group1,group2,group3 exampleusername
GRPS=staff,adm,dialout,cdrom,audio,video,plugdev,users,input,netdev,gpio,i2c,spi
usermod -a -G ${GRPS} mday
usermod -a -G ${GRPS} tday

setup-ssh mday
setup-ssh tday
