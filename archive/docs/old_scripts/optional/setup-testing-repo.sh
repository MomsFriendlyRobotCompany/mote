#!/bin/bash
set -e

# check if we are root
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit 1
fi

echo ""
echo "============================="
echo "| Setting Up Testing Repos  |"
echo "============================="
echo ""

TEST="buster"
STABLE="stretch"

cat > /etc/apt/sources.list.d/${TEST}.list <<EOF
deb http://raspbian.raspberrypi.org/raspbian/ ${TEST} main contrib non-free rpi
# deb-src http://raspbian.raspberrypi.org/raspbian/ ${TEST} main contrib non-free rpi
EOF

cat > /etc/apt/preferences.d/${TEST}.pref <<EOF
Package: *
Pin: release a=${TEST}
Pin-Priority: 100
EOF

cat > /etc/apt/preferences.d/${STABLE}.pref <<EOF
Package: *
Pin: release a=${STABLE}
Pin-Priority: 700
EOF

cat > /etc/apt/preferences.d/stable.pref <<EOF
Package: *
Pin: release a=stable
Pin-Priority: 900
EOF

apt update
apt install -y python3 python3-venv python3-dev cmake build-essential -t testing 
