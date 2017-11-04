#!/bin/bash

WLAN=wlan0
HOSTNAME=hello

cat <<EOF >hostapd.conf
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


cat <<EOF >hostapd.service
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
