#!/bin/bash
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
  echo "  upgrade-os.sh jessie stretch
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

# change distro name
sed -i 's/${OLD_DISTRO}/${DISTRO}/g' /etc/apt/sources.list

# now do the actual upgrade
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y

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
