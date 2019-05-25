#!/bin/bash
set -e

# check if we are root
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit 1
fi

echo ""
echo "============================="
echo "|  Setting Up OLED Status   |"
echo "============================="
echo ""

echo "*** update python ***"
runuser -l pi -c 'source /home/pi/.venv/bin/activate;pip install -U Adafruit-SSD1306 pillow netifaces psutil'

echo "*** setup script ***"

# setup the service
# REREAD=""
SCRIPT="static/lcd.py"
# TIMER="/etc/systemd/system/autoupgrade.timer"
SERVICE="/etc/systemd/system/oled.service"


# if the file exists, remove it ... going to dynamically create it
# if [[ -f "${TIMER}" ]]; then
#   REREAD="true"
# fi
#
# cat <<'EOF' >${SCRIPT}
#
# EOF

# fix permissions
chmod 755 ${SCRIPT}

echo "*** setup service ***"

EXE=pwd

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
