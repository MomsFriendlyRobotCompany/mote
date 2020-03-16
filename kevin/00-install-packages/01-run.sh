#!/bin/bash -e

on_chroot << EOF
# this fixed my curl problem
update-ca-certificates --fresh
EOF
