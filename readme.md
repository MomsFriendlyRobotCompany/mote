![](pics/mote.jpg)

# mote

Setup Raspberry Pi's using RPi-Distro [pi-gen](https://github.com/RPi-Distro/pi-gen)
and docker images.

- locale is set for en_us.utf-8 and us keyboard
- default pi password is changed
- Setup `samba`
- Wifi setup for *ssid* and *passwd*
- Commandline is `zsh`
- `Python3` virtualenv (venv) setup
- `ssh` with default ed25519 keys
- login motd will show useful info (see below)

Command line:

```
kevin@Logan lib $ ssh pi@raven.local
Last login: Mon May  8 01:36:22 2017 from fe80::f41f:25ff::e764%usb0

 _ __ __ ___   _____ _ __  
| '__/ _` \ \ / / _ \ '_ \
| | | (_| |\ V /  __/ | | |
|_|  \__,_| \_/ \___|_| |_|


Wednesday, 10 May 2017,  2:17:19 am UTC
Linux 4.9.26+ armv6l GNU/Linux

Uptime.............: 0 days, 00h00m42s
Memory.............: 253 MB (Free) / 370 MB (Total)
Storage............: 1.9GB (Free) / 15GB (Total)
Load Averages......: 0.85, 0.24, 0.08 (1, 5, 15 min)
CPU Temperature....: 78 F
Running Processes..: 93
IP Addresses.......: 192.168.2.18
```

## Setup

- Install: `sudo apt install libarchive-tools coreutils quilt parted qemu-user-static debootstrap zerofree zip dosfstools libcap2-bin grep rsync xz-utils file git curl bc`

## `config`

The below `config` file assumes you use the apt-cache docker container and
start it with: `docker-compose up -d`.

```
IMG_NAME="mote"
TARGET_HOSTNAME="mote"
FIRST_USER_PASS="<passwd>"
DEPLOY_ZIP=1
LOCALE_DEFAULT="en_US.UTF-8"
KEYBOARD_KEYMAP="us"
KEYBOARD_LAYOUT="English (US)"
ENABLE_SSH=1
STAGE_LIST="stage0 stage1 stage2 kevin robot"
WPA_ESSID=<ssid>
WPA_PASSWORD=<passwd>
WPA_COUNTRY=us
APT_PROXY=http://172.17.0.1:3142
```

## Build

Basically you just run `./setup.sh user_pwd ssid ssid_pwd` and it does the following:

1. Clone [pi-gen](https://github.com/RPi-Distro/pi-gen): `git clone --depth=1 https://github.com/RPi-Distro/pi-gen.git`
1. `cp -R kevin pi-gen/`
1. `cp config pi-gen`
	- Set correct `<ssid>` and `<passwd>` for your network
	- Set correct `<passwd>` for default user
1. `cd pi-gen`
1. `rm -fr stage3 stage4 stage5 export-noobs`
1. `rm stage2/EXPORT_NOOB`
1. `mv stage2/EXPORT_IMAGE kevin/`
1. `./build-docker.sh`
	- `PRESERVE_CONTAINER=1` keeps the container around so you can look at it, but you can leave it out too
	- If the build fails, you can fix the error and then run: `CONTINUE=1 ./build-docker.sh`
1. When complete, the zipped image should be in the folder: `deploy`
    - **Unfortunately** the image sizes exceed what github allows, so they are not in the repo

## Continuing Work

If you make changes and want to rebuild you can do:

- Start over completely from scratch: `./build-docker.sh`
- Continue only update what you have changed: `CONTINUE=1 ./build-docker.sh`

# Things Learned

- To get access to the image root file system, use `${ROOTFS_DIR}/<some_file>`
- Can't use `mv`, need to use `install -m 644 <from> <to`
- **00-packages**: is `apt-get install -y $PACKAGES`
- **00-packages-nr**: is `apt-get install --no-install-recommends -y $PACKAGES`
- No matter how you do it, you can't pre-install a current version of node using
the [script](https://github.com/nodesource/distributions/blob/master/README.md#deb)
from the website

# References

- [samba and dialog boxes issue](https://askubuntu.com/a/104912)
- [another samba dialog box issue](https://raphaelhertzog.com/2010/09/21/debian-conffile-configuration-file-managed-by-dpkg/)

# Change Log

| Date       | Rev   | Comment |
|------------|-------|---------|
| 2020-03-15 | 0.5.0 | moved to pi-gen 2020-02-13-raspbian-buster |
| 2017-04-04 | 0.1.0 | scripts working |

# MIT License

Copyright (c) 2017 Kevin J. Walchko

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
