#!/bin/bash -e

install -m 644 files/raspberrypi-hostname-mods.service "${ROOTFS_DIR}/etc/systemd/system/"

# on_chroot << EOF
# # purge any old versions
# apt-get remove --purge nodejs
# apt-get autoremove
#
# # update and install
# echo ">> Setting up apt-key"
# # curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
#
# echo ">> Getting Node"
# curl -sL https://deb.nodesource.com/setup_13.x | bash -
# apt-get install -y nodejs
#
# # update npm
# npm install npm@latest -g
# npm install -g httpserver archeyjs
#
# # update and start
# systemctl --no-pager enable archeyjs
# # systemctl --no-pager start archeyjs
# EOF
