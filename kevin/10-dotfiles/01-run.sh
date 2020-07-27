#!/bin/bash -e

#install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/github"

on_chroot << EOF
# get dotfiles -----------------------------

# ZSH ---------
if [[ -d "/home/${FIRST_USER_NAME}/.zshrc" ]]
    SUDO_USER="${FIRST_USER_NAME}" mv .zshrc .zshrc.orig
    SUDO_USER="${FIRST_USER_NAME}" ln -s /home/${FIRST_USER_NAME}/github/dotfiles/zshrc home/${FIRST_USER_NAME}/.bashrc
fi

# BASH --------
SUDO_USER="${FIRST_USER_NAME}" mv .bashrc .bashrc.orig
SUDO_USER="${FIRST_USER_NAME}" ln -s /home/${FIRST_USER_NAME}/github/dotfiles/bashrc home/${FIRST_USER_NAME}/.zshrc

# MOTD -------
rm /etc/motd
touch /etc/motd

mv /etc/profile.d/motd.sh.orig
ln -s /home/${FIRST_USER_NAME}/github/dotfiles/motd /etc/profile.d/motd.sh

EOF
