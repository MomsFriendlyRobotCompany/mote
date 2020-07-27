#!/bin/bash
# Setup a virtual python3 env
# sudo: yes
set -e

# check if we are root
if ! [ $(id -u) = 0 ]; then 
  echo "Please run as ROOT"
  exit 1
fi

#--------------------------------------------------
apt install -y python3-venv 
apt install -y python3-dev
#--------------------------------------------------

su - pi <<'EOF'
python3 -m venv /home/pi/.venv
source /home/pi/.venv/bin/activate
pip install -U pip setuptools wheel
pip install -U build_utils
EOF
