#!/bin/bash -e

install -v -o 1000 -g 1000 -m 644 "files/bashrc" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.bashrc"

on_chroot << EOF
chsh -s /bin/bash "${FIRST_USER_NAME}"
EOF
