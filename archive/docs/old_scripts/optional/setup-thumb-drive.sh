!#/bin/bash

set -e

# check if we are root
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit 1
fi

echo ""
echo "============================="
echo "| Setting Up Thumb Drive    |"
echo "============================="
echo ""

USER=pi
DISK=sdc1

# setup mount point
mkdir -p /media/usb
chown ${USER} /media/usb
chmod 0777 /media/usb

# setup fstab to mount it
echo /dev/${DISK} /media/usb auto user,umask=000,utf8,noauto 0 0 >> /etc/fstab

echo "All done setting up thumb drive ..."
