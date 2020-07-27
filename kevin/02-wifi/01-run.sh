#!/bin/bash -e

on_chroot << EOF
# turn wifi on - not sure if this works without country code change
sudo rfkill unblock all
EOF
