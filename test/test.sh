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

NODE=`which nodejs`
LOCAL=false
if [[ "${NODE}" =~ "/usr/local" ]]; then
	LOCAL=true
fi

echo ${LOCAL}
