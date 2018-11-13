#!/bin/bash
# based off this question/answer
# https://raspberrypi.stackexchange.com/questions/78787/howto-migrate-from-networking-to-systemd-networkd-with-dynamic-failover/78788#78788
# https://raspberrypi.stackexchange.com/questions/88599/rpi3-raspbian-stretch-regular-connection-on-wlan0-ap-on-wlan1

set -e

# check if we are root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

if [[ $# -eq 4 ]]; then
  WIFI_SSID=$1
  WIFI_PASSWORD=$2
  SSID=$3
  PASSWORD=$4
else
  echo "Usage:"
  echo "$0 WIFI_SSID WIFI_PASSWORD SSID PASSWORD"
  echo "  WIFI_SSID/PASSWORD: info for wifi network with access to internet"
  echo "  SSID/PASSWORD: info for RPi access point to create"
  exit 1
fi

echo ">> Disabling old network system and enabling new one"

# disable classic networking
systemctl mask networking.service
systemctl mask dhcpcd.service
mv /etc/network/interfaces /etc/network/interfaces~
sed -i '1i resolvconf=NO' /etc/resolvconf.conf

# enable systemd-networkd
systemctl enable systemd-networkd.service
systemctl enable systemd-resolved.service
ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

# setup wlan0 ---------------------------------------------------
# connects to local wifi network
echo ">> Internet access on wlan0: ${WIFI_SSID}/${WIFI_PASSWORD}"

cat > /etc/wpa_supplicant/wpa_supplicant-wlan0.conf <<EOF
country=US
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="${WIFI_SSID}"
    psk="${WIFI_PASSWORD}"
}
EOF

chmod 600 /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
systemctl enable wpa_supplicant@wlan0.service

mkdir -p /etc/systemd/system/wpa_suplicant@wlan0.service.d
cat > /etc/systemd/system/wpa_suplicant@wlan0.service.d/override.conf <<EOF
[Service]
ExecStartPre=/sbin/iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
ExecStopPost=-/sbin/iptables -t nat -D POSTROUTING -o wlan0 -j MASQUERADE
EOF

# setup wlan1 ---------------------------------------------------
# creates an access point
echo ">> RPi AP on wlan1: ${SSID}/${PASSWORD}"

cat > /etc/wpa_supplicant/wpa_supplicant-wlan1.conf <<EOF
country=US
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

ap_scan=2
network={
    ssid="${SSID}"
    mode=2
    key_mgmt=WPA-PSK
    psk="${PASSWORD}"
}
EOF

chmod 600 /etc/wpa_supplicant/wpa_supplicant-wlan1.conf
systemctl enable wpa_supplicant@wlan1.service

# setup eth0 -------------------------------------------------
echo ">> Setting up eth0"

cat >/etc/systemd/network/04-eth.network <<EOF
[Match]
Name=eth0
[Network]
DHCP=yes
# to use static IP uncomment these instead of DHCP
#Address=192.168.1.86/24
#Gateway=192.168.1.1
EOF

chown systemd-network:adm /etc/systemd/network/04-eth.network

echo ">> Enabling interfaces"

# setup interface to wifi with access to internet
cat > /etc/systemd/network/08-wlan0.network <<EOF
[Match]
Name=wlan0
[Network]
DHCP=yes
EOF

# setup interface for access point
cat > /etc/systemd/network/12-wlan1.network <<EOF
[Match]
Name=wlan1
[Network]
Address=10.10.10.1/24
IPForward=yes
DHCPServer=yes
EOF

echo "*******************************"
echo "* All done, please reboot now *"
echo "*******************************"

# systemctl --no-pager enable hostapd
# sleep 1
# systemctl --no-pager start dnsmasq
# sleep 1
# systemctl --no-pager start hostapd
# sleep 1
