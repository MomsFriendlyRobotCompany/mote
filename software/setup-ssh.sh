#!/bin/bash

set -e

# check if we are root
if [ "$EUID" -eq 0 ]
	then echo "Please run as root"
	exit 1
fi

USR="pi"
HOME="/home/${USR}"

if [ ! -f "${HOME}/.ssh/id_rsa" ]; then
	ssh-keygen -q -N "" -f ${HOME}/.ssh/id_rsa -t rsa
else
	echo ""
	echo "ssh already setup"
fi

ssh-keygen -lvf ${HOME}/.ssh/id_rsa.pub
echo ""
