#!/bin/bash
# https://linuxconfig.org/raspbian-gnu-linux-upgrade-from-jessie-to-raspbian-stretch-9
#
# This isn't perfect ... there are places where you have to answer questions
# certificates - q (quit ... stupid notice)
# bashrc - n (no - keep your bashrc file)
# login.def - y (yes - upgrade it)
# gpg - q (quit ... stupid notice)
# services - y (yes - upgrade services w/o asking me on each one)

set -e

# check if we are root
if [ "$EUID" -ne 0 ] ; then
  echo
  echo "*** Please run as root ***"
  echo ""
	exit 1
fi

if [[ $# -ne 2 ]] ; then
  echo "-------------------------------------------"
  echo "Please supply the old and new distro name"
  echo "  upgrade-os.sh jessie stretch"
  echo "-------------------------------------------"
  exit 1
fi

OLD_DISTRO=$1
DISTRO=$2

echo ""
echo "============================="
echo "| Setting Up ${DISTRO}"
echo "============================="
echo ""

# make sure everything is up-to-date
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get autoremove -y

# there are stupid dialogs that open up ... try to stop them (don't know if this will work)
export DEBIAN_FRONTEND=noninteractive

# change distro name in repo lists
# substitute (s) OLD_DISTRO with DISTRO, globally (g)
sed -i "s/${OLD_DISTRO}/${DISTRO}/g" /etc/apt/sources.list
sed -i "s/${OLD_DISTRO}/${DISTRO}/g" /etc/apt/sources.list.d/nodesource.list
sed -i "s/${OLD_DISTRO}/${DISTRO}/g" /etc/apt/sources.list.d/raspi.list

# now do the actual upgrade
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get autoremove  # there is some old stuff now ... get rid of it

# get back git
apt-get install git -y

echo ""
echo "============================================="
echo "| ${DISTRO} installed ... reboot in 3 sec"
echo "============================================="
echo ""

sleep 1
echo "."
sleep 1
echo "."
sleep 1
echo "."

reboot now
