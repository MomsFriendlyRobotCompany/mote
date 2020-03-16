#!/bin/bash -e

on_chroot << EOF
mkdir /home/${FIRST_USER_NAME}/.ssh
SUDO_USER="${FIRST_USER_NAME}" ssh-keygen -q -N "" -f /home/${FIRST_USER_NAME}/.ssh/id_ed25519 -t ed25519 -a 100
# systemctl enable ssh # handled by config
chown -R ${FIRST_USER_NAME}:${FIRST_USER_NAME} /home/${FIRST_USER_NAME}

sudo rfkill unblock all
EOF
