#!/bin/bash

# check for root
# if [ "$EUID" -ne 0 ]
#   then echo "Please run as root"
#   exit
# fi

# ARCHEYJS_FILE="archeyjs.service"
#
# if [[ ! -f "${ARCHEYJS_FILE}" ]]; then
# 	rm ${ARCHEYJS_FILE}
# fi
#
# ARCHEYJS=`which archeyjs`
#
# SERVICE="\
# [Service] \n                              \
# ExecStart=${ARCHEYJS} \n     \
# Restart=always \n                        \
# StandardOutput=syslog\n                \
# StandardError=syslog\n                \
# SyslogIdentifier=archeyjs\n              \
# User=pi\n                            \
# Group=pi\n \
# Environment=NODE_ENV=production\n \
# \n \
# [Install]\n \
# WantedBy=multi-user.target\n"
#
# # The -e makes echo respect the \n properly
# echo -e ${SERVICE} > ${ARCHEYJS_FILE}

# NODE=`which nodejs`
# LOCAL=false
# if [[ "${NODE}" =~ "/usr/local" ]]; then
# 	LOCAL=true
# fi
#
# echo ${LOCAL}

# PY2_VER=$(python3 --version 2>&1)
#
# echo ""
# echo "============================="
# echo "| Setting up ${PY2_VER}"
# echo "============================="
# echo ""

# need to pass in SSID and password
if [[ $# -ne 2 ]] ; then
	echo ""
	echo "Please supply a 2 args: SSID and PASSWORD"
	echo ""
	exit 1
fi

SSID=$1
PASSWORD=$2
# HASH=`wpa_passphrase ${SSID} ${PASSWORD} | grep psk | awk '!/#/'`
HASH="psk=42f638ae9a8a65275684a72ebf1879b98d0a2469eb3d829995a62aa5691f6615"

# split the string on '='
IFS='=' read -a myarray <<< "${HASH}"

HASH="${myarray[1]}"

INFO="\n\
network={ \n\
    ssid=\"${SSID}\" \n\
    key_mgmt=WPA-PSK \n\
    proto=WPA2 \n\
    psk=\"${HASH}\" \n\
} \n"

echo -e "${INFO}" >> test.txt
