#!/bin/bash -e

PYPI_FILES="pyserial \
    numpy \
    picamera[array] \
    imutils \
    keras \
    pyzmq \
    msgpack \
    squaternion"

on_chroot << EOF
    # ls -al /home/${FIRST_USER_NAME}
    # SUDO_USER="${FIRST_USER_NAME}" . /home/${FIRST_USER_NAME}/venv/bin/activate && pip install -U ${PYPI_FILES}

EOF
