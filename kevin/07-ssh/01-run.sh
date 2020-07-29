#!/bin/bash -e

on_chroot << EOF

if [[ ! -d "/home/${FIRST_USER_NAME}/.ssh" ]]; then
    mkdir -p /home/${FIRST_USER_NAME}/.ssh
    SUDO_USER="${FIRST_USER_NAME}" ssh-keygen -q -N "" -f /home/${FIRST_USER_NAME}/.ssh/id_ed25519 -t ed25519 -a 100
fi

EOF
