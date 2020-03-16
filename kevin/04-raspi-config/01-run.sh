#!/bin/bash -e

# constants -----------------------------------------
# 0 - on
# 1 - off
# on_chroot << EOF
# raspi-config nonint do_i2c 0
# raspi-config nonint do_spi 0
# raspi-config nonint do_camera 0
# raspi-config nonint do_wifi_country US
# EOF
