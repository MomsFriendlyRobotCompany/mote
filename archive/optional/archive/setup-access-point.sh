#!/bin/bash
# you can pass an arg of which adaptor to use for the access point
# setup-access-point wlan1

set -e

# check if we are root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

# this is the access point
WLAN="wlan1"

# # need wireless adaptor
# if [[ $# -ne 1 ]] ; then
#   WLAN="wlan1"
# else
#   WLAN=$1
# fi

echo ""
echo "+-------------------------+"
echo "| Setting up Access Point |"
echo "+-------------------------+"
echo " using ${WLAN}"
echo " WARNING: only run once!"
echo ""

# Since this appends things to files, I don't want to append the
# same thing multiple times ... not sure what kind of software
# hell that would create!
if [[ -f "/etc/dnsmasq.conf" ]]; then
  echo ""
  echo " You have already run this ... do it by hand"
  echo ""
  exit 1
fi

echo "<<< Updating and installing software >>>"

apt-get update
apt-get -y install dnsmasq hostapd
systemctl stop dnsmasq
systemctl stop hostapd

echo "<<< Setting up interfaces, moving current config file to *.orig >>>"

# OMFG this doesn't work!!!
# if /etc/network/interfaces has anything in it, then dhcpcd.config
# doesn't run. Besides, interfaces is the OLD way, but starting with
# Jessie, dhcpcd.conf is the new way going forward -- doesn't work
mv /etc/dhcpcd.conf /etc/dhcpcd.conf.orig
cat <<EOF >/etc/dhcpcd.conf
# Inform the DHCP server of our hostname for DDNS.
hostname

# Use the hardware address of the interface for the Client ID.
clientid

# Persist interface configuration when dhcpcd exits.
persistent

# Rapid commit support.
# Safe to enable by default because it requires the equivalent option set
# on the server to actually work.
option rapid_commit

# A list of options to request from the DHCP server.
option domain_name_servers, domain_name, domain_search, host_name
option classless_static_routes
# Most distributions have NTP support.
option ntp_servers
# Respect the network MTU. This is applied to DHCP routes.
option interface_mtu

# A ServerID is required by RFC2131.
require dhcp_server_identifier

# Generate Stable Private IPv6 Addresses instead of hardware based ones
slaac private

# kevin
###################################
# main wifi
# this seems to have trouble
interface wlan0
  dhcp
  ipv4

# access point
interface wlan1
  static ip_address=10.10.10.1/24
  static routers=10.10.10.1
  nohook wpa_supplicant
  
EOF

# don't need this anymore
# mv /etc/network/interfaces /etc/network/interfaces.orig
# cat <<EOF >/etc/network/interfaces
# # interfaces(5) file used by ifup(8) and ifdown(8)

# # Please note that this file is written to be used with dhcpcd
# # For static IP, consult /etc/dhcpcd.conf and 'man dhcpcd.conf'

# # Include files from /etc/network/interfaces.d:
# source-directory /etc/network/interfaces.d
# allow-hotplug ${WLAN}
# iface ${WLAN} inet static
#   address 10.10.10.1
#   netmask 255.255.255.0
#   network 10.10.10.0

# # for some reason, we loose eth0 for wired, so add it back in
# auto eth0
# allow-hotplug eth0
# iface eth0 inet dhcp
# EOF

echo "<<< Setting up DNSMASQ >>>"

# setup the dhcpd
# dhcp-range: start, end, mask, lease time
# backup the default one and write a new one
mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
cat <<EOF >/etc/dnsmasq.conf
interface=${WLAN}      # Use the usb wifi dongle
dhcp-range=10.10.10.5,10.10.10.100,255.255.255.0,24h
EOF

echo "<<< Setting up HOSTAPD >>>"

# remove the old init.d version
mv /etc/init.d/hostapd /etc/init.d/hostapd.orig

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

cat <<EOF >/etc/systemd/system/hostapd.service
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

systemctl --no-pager enable hostapd
sleep 1
systemctl --no-pager start dnsmasq
sleep 1
systemctl --no-pager start hostapd
sleep 1
