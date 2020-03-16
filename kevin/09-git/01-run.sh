#!/bin/bash -e

install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/github"

on_chroot << EOF
SUDO_USER="${FIRST_USER_NAME}" git config --global user.name walchko
SUDO_USER="${FIRST_USER_NAME}" git config --global user.email walchko@users.noreply.github.com
SUDO_USER="${FIRST_USER_NAME}" git config --global push.default simple
EOF
