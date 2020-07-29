#!/bin/bash -e

PYPI_FILES="protobuf"

# on_chroot << EOF
#     # build gecko-protobuf cpp
#     # this also builds latest google protobuf
#     # git clone --depth 1 https://github.com/gecko-robotics/gecko-protobuf.git
#     # mkdir -p gecko-protobuf/cpp/build
#     # cd gecko-protobuf/cpp
#     # ./build_extlibs.sh
#     # cd build
#     # cmake ..
#     # make install
#
# EOF
#
# on_chroot << EOF
#     ls -al /home/${FIRST_USER_NAME}
#     SUDO_USER="${FIRST_USER_NAME}" . /home/${FIRST_USER_NAME}/venv/bin/activate && pip install -U ${PYPI_FILES}
# EOF
