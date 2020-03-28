#!/bin/bash -e

# on_chroot << EOF
#     SUDO_USER="${FIRST_USER_NAME}" pip install -U opencv-contrib-python-headless
#
#     chown -R ${FIRST_USER_NAME}:${FIRST_USER_NAME} /home/${FIRST_USER_NAME} # fix permissions
#
# EOF
