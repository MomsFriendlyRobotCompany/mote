#!/bin/bash
set -e

# check if we are root
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit 1
fi

# print("Pillow/PIL fail to build ... exiting")
# exit 1

echo ""
echo "============================="
echo "|  Setting Up OLED Status   |"
echo "============================="
echo ""

# deactivate  # shutdown virtual env
apt install -y python3-pip

echo "*** update python ***"
pip3 install -U Adafruit-SSD1306 pillow netifaces psutil RPi.GPIO

echo "*** setup script ***"

# setup the service
SCRIPT="static/lcd.py"
SERVICE="/etc/systemd/system/oled.service"

# fix permissions on static/lcd.py
chmod 755 ${SCRIPT}

if [[ -f "${SERVICE}" ]]; then
	echo "*** removing ${SERVICE} ***"
	rm -f ${SERVICE}
fi


echo "*** setup service ***"

EXE=`pwd`

cat > ${SERVICE} <<EOF
[Service]
ExecStart=${EXE}/${SCRIPT}
Restart=always
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=oled
User=pi
Group=pi

[Install]
WantedBy=multi-user.target
EOF

# if [[ -z "${REREAD}" ]]; then
#   echo "*** enabling/starting timer and service ***"
#   systemctl start autoupgrade.timer
#   systemctl enable autoupgrade.timer
#   systemctl start autoupgrade.service
#   echo " to see timers, run: sudo systemctl list-timers --all"
#   echo " to see output, run: sudo journalctl -u autoupgrade"
# else
#   echo "*** need to reload service due to changes ***"
#   systemctl daemon-reload
#   systemctl start autoupgrade.timer
#   systemctl enable autoupgrade.timer
#   systemctl start autoupgrade.service
# fi


systemctl daemon-reload
systemctl enable oled.service
systemctl start oled.service

echo ""
echo "*** $0 Done ***"
echo ""
