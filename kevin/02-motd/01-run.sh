#!/bin/bash -e

rm -f ${ROOTFS_DIR}/etc/profile.d/motd.sh
rm -f ${ROOTFS_DIR}/etc/motd
touch ${ROOTFS_DIR}/etc/motd

install -m 744 files/motd.sh ${ROOTFS_DIR}/etc/profile.d/motd.sh
