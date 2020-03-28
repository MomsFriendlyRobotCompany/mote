#!/bin/bash

set -e

# check if we are root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Unfortunately, nodejs is installed in different places, need to find it
NODE=`command -v node`
LOCAL="no"

if [[ "${NODE}" =~ "/usr/local" ]]; then
	echo "Node installed in /usr/local"
	LOCAL="yes"
else
	echo "Node installed in /usr"
fi

# install archey
if [[ "${LOCAL}" =~ "yes" ]]; then
	su - pi -c "npm install -g archeyjs"
else
	npm install -g archeyjs
fi

# setup the service
ARCHEYJS_FILE="/etc/systemd/system/archeyjs.service"

# if the file exists, remove it ... going to dynamically create it
if [[ -f "${ARCHEYJS_FILE}" ]]; then
	rm ${ARCHEYJS_FILE}
fi

# ARCHEYJS=`which archeyjs`
ARCHEYJS=`command -v archeyjs`

cat <<EOF >${ARCHEYJS_FILE}
[Service]
ExecStart=${ARCHEYJS}
Restart=always
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=archeyjs
User=pi
Group=pi
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
EOF

# update and start
systemctl --no-pager enable archeyjs
systemctl --no-pager start archeyjs
# service archeyjs status

echo ""
echo "*** $0 Done ***"
echo ""
