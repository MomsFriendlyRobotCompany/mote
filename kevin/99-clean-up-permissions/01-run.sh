#!/bin/bash -e

on_chroot << EOF

chown -R ${FIRST_USER_NAME}:${FIRST_USER_NAME} /home/${FIRST_USER_NAME}

EOF
