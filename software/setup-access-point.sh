#!/bin/bash

set -e

# check if we are root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

WLAN=""

# need wireless adaptor
if [[ $# -ne 1 ]] ; then
	# echo ""
	# echo "Please supply 1 args: WLANX where X is 0 or 1"
	# echo ""
	# exit 1
  WLAN="wlan0"
else
  WLAN=$1
fi

echo ""
echo "+-------------------------+"
echo "| Setting up Access Point |"
echo "+-------------------------+"
echo " WARNING: only run once!"
echo ""

# Since this appends things to files, I don't want to append the
# same thing multiple times ... not sure what kind of software
# hell that would create!
if [[ -f "/etc/dnsmasq.conf" ]]; then
  echo ""
  echo " You have already run this ... do it by hand"
  echo ""
  return 1
fi

echo "<<< Updating and installing software >>>"

apt-get update
apt-get -y install dnsmasq hostapd
systemctl stop dnsmasq
systemctl stop hostapd

echo "<<< Setting up interfaces, moving current config file to *.orig >>>"

# mv /etc/network/interfaces /etc/network/interfaces.orig
cat <<EOF >>/etc/network/interfaces
allow-hotplug ${WLAN}
iface ${WLAN} inet static
  address 10.10.10.1
  netmask 255.255.255.0
  network 10.10.10.0
EOF

echo "<<< Setting up DNSMASQ >>>"

# setup the dhcpd
# dhcp-range: start, end, mask, lease time
# backup the default one and write a new one
mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
cat <<EOF >/etc/dnsmasq.conf
interface=${WLAN}      # Use the usb wifi dongle
dhcp-range=10.10.10.5,10.10.10.100,255.255.255.0,24h
EOF

# changing dhcp, don't assign something to ${WLAN} ... leave out wlan0
echo -e "denyinterfaces ${WLAN}" >> /etc/dhcpcd.conf

echo "<<< Setting up HOSTAPD >>>"

# remove the old init.d version
rm -f /etc/init.d/hostapd

# the SSID for the access point will be the hostname
HOSTNAME=`uname -n  | sed -e s/.local//`

echo "<<< SSID is: "${HOSTNAME}" >>>"

# write config file
cat <<EOF >/etc/hostapd/hostapd.conf
interface=${WLAN}
ssid=${HOSTNAME}
channel=10
auth_algs=1
wpa=2
wpa_passphrase=robotsarecool
wpa_key_mgmt=WPA-PSK
wpa_pairwise=CCMP
rsn_pairwise=CCMP
EOF

cat <<EOF >/etc/system.d/system/hostapd.service
[Unit]
Description=Hostapd Access Point
After=sys-subsystem-net-devices-${WLAN}.device
BindsTo=sys-subsystem-net-devices-${WLAN}.device

[Service]
Type=forking
PIDFile=/var/run/hostapd.pid
ExecStart=/usr/sbin/hostapd -B /etc/hostapd/hostapd.conf -P /var/run/hostapd.pid

[Install]
WantedBy=multi-user.target
EOF

systemctl enable hostapd
systemctl start dnsmasq
systemctl start hostapd
