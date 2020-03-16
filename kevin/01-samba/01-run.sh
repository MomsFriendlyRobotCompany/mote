#!/bin/bash -e

# install:
#     samba-common-bin
#     samba
on_chroot << EOF
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install samba samba-common-bin
EOF

if [ -f "${ROOTFS_DIR}/etc/samba/smb.conf" ]; then
	mv ${ROOTFS_DIR}/etc/samba/smb.conf ${ROOTFS_DIR}/etc/samba/smb.bak
fi

install -m 644 files/smb.conf ${ROOTFS_DIR}/etc/samba

on_chroot << EOF
# echo "${FIRST_USER_PASS}\n${FIRST_USER_PASS}" > smbpasswd  -s -a pi
echo -ne "${FIRST_USER_PASS}\n${FIRST_USER_PASS}\n" | smbpasswd -a -s ${FIRST_USER_NAME}
EOF
