#!/bin/bash

set -e

# check if we are root
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit 1
fi

USR="pi"
HOME="/home/${USR}"

if [ ! -f "${HOME}/.ssh/id_rsa" ]; then
	su ${USR} -c "ssh-keygen -q -N \"\" -f ${HOME}/.ssh/id_rsa -t rsa"
else
	echo ""
	echo "ssh already setup"
fi

su ${USR} -c "ssh-keygen -lvf ${HOME}/.ssh/id_rsa.pub"
echo ""
