#!/bin/bash -e

on_chroot << EOF
    /usr/bin/python3 -m venv /home/${FIRST_USER_NAME}/venv
    . /home/${FIRST_USER_NAME}/venv/bin/activate && pip install -U pip setuptools wheel
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | SUDO_USER="${FIRST_USER_NAME}" python3

    # pip install -U twine numpy pyserial RPi.GPIO psutil pytest simplejson colorama importlib-metadata

    chown -R ${FIRST_USER_NAME}:${FIRST_USER_NAME} /home/${FIRST_USER_NAME} # fix permissions

    # SUDO_USER="${FIRST_USER_NAME}" ${ROOTFS_DIR}/usr/bin/python3 -m venv ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/venv
    # SUDO_USER="${FIRST_USER_NAME}"  . ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/venv/bin/activate \
    # && pip install -U pip setuptools wheel
EOF
