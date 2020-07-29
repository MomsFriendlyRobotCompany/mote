#!/bin/bash -e

#install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/github"

on_chroot << EOF
# get dotfiles -----------------------------
if [[ ! -d "/home/${FIRST_USER_NAME}/github/dotfiles" ]]; then
    cd /home/${FIRST_USER_NAME}/github
    SUDO_USER="${FIRST_USER_NAME}" git clone --depth 1 https://github.com/walchko/dotfiles.git
    SUDO_USER="${FIRST_USER_NAME}" ln -s /home/${FIRST_USER_NAME}/github/dotfiles/bashrc home/${FIRST_USER_NAME}/.bashrc
    cd /home/${FIRST_USER_NAME}
fi

# ZSH ---------
if [[ -f "/home/${FIRST_USER_NAME}/.zshrc" ]]; then
    mv /home/${FIRST_USER_NAME}/.zshrc /home/${FIRST_USER_NAME}/.zshrc.orig
    ln -s /home/${FIRST_USER_NAME}/github/dotfiles/zshrc home/${FIRST_USER_NAME}/.bashrc
fi

# BASH --------
if [[ -f "/home/${FIRST_USER_NAME}/.bashrc" ]]; then
    mv /home/${FIRST_USER_NAME}/.bashrc /home/${FIRST_USER_NAME}/.bashrc.orig
    ln -s /home/${FIRST_USER_NAME}/github/dotfiles/bashrc /home/${FIRST_USER_NAME}/.zshrc
fi

# MOTD -------
rm /etc/motd
touch /etc/motd

mv /etc/profile.d/motd.sh.orig
ln -s /home/${FIRST_USER_NAME}/github/dotfiles/motd /etc/profile.d/motd.sh

EOF
