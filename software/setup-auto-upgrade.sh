#!/bin/bash
set -e

# check if we are root
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit 1
fi

echo ""
echo "============================="
echo "| Setting Up Auto Upgrade   |"
echo "============================="
echo ""

echo "*** setup script ***"

# setup the service
REREAD=""
SCRIPT="static/autoupgrade.sh"
TIMER="/etc/systemd/system/autoupgrade.timer"
SERVICE="/etc/systemd/system/autoupgrade.service"


# if the file exists, remove it ... going to dynamically create it
if [[ -f "${TIMER}" ]]; then
  REREAD="true"
fi

cat <<'EOF' >${SCRIPT}
#!/bin/bash

# check online
wget -q --spider http://google.com

if [ $? -eq 0 ]; then
  echo "*** Online ***"
else
  echo "*** Offline, no access to internet ***"
  return 1
fi

echo "*** upgrade base system ***"
apt-get update
apt-get upgrade -y
apt-get autoclean

echo "*** upgrade python 2 ***"
pip list --format=legacy --outdated | cut -d' ' -f1 | xargs pip install --upgrade

echo "*** upgrade python 3 ***"
pip3 list --format=legacy --outdated | cut -d' ' -f1 | xargs pip3 install --upgrade

echo "*** update npm packages ***"
npm i -g npm
npm update -g

# remove the old file, so we don't get a million of them
UFILE=`find /home/pi -name 'system-updated-on*'`
if [[ ! -z "${UFILE}" ]]; then
  rm ${UFILE}
fi

# let people know we upgraded things
FNAME=`date | { read x; echo "${x// /-}"; }`
touch "/home/pi/system-updated-on-${FNAME}"
chown pi:pi "/home/pi/system-updated-on-${FNAME}"

chown -R pi:pi /usr/local

exit 0
EOF

# fix permissions
chmod 755 ${SCRIPT}

echo "*** setup timer ***"

cat<<'EOF' > ${TIMER}
[Unit]
Description=Weekly update

[Timer]
OnCalendar=weekly
Persistent=true

[Install]
WantedBy=timers.target
EOF

echo "*** setup service ***"

cat <<EOF > ${SERVICE}
[Unit]
Description=Updates system weekly
Wants=audoupgrade.timer

[Service]
Type=simple
ExecStart=/home/pi/github/mote/software/static/autoupgrade.sh
EOF

if [[ -z "${REREAD}" ]]; then
  echo "*** enabling/starting timer and service ***"
  systemctl start autoupgrade.timer
  systemctl enable autoupgrade.timer
  systemctl start autoupgrade.service
  echo " to see timers, run: sudo systemctl list-timers --all"
  echo " to see output, run: sudo journalctl -u autoupgrade"
else
  echo "*** need to reload service due to changes ***"
  systemctl daemon-reload
  systemctl start autoupgrade.timer
  systemctl enable autoupgrade.timer
  systemctl start autoupgrade.service
fi

echo ""
echo "*** $0 Done ***"
echo ""
