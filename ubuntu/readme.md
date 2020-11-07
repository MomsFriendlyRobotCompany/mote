![](https://i.redd.it/n0vaia0w2yl21.png)

# Creating a Useful Ubuntu Image

Download: [ARM Ubuntu 20.04 LTS Server](https://ubuntu.com/download/server/arm)

Ubuntu server has a lot of useless shit on it when you are doing an
embedded system. Some of the changes:

- Remove:
    - `snapd` and all software ... it is too slow
    - `unattended-upgrades`
- Install and Setup
    - Change MOTD to give useful information
    - Set hostname
    - Set time zone
    - Install Python3
    - Install `samba` and export home share
    - Set I2C to default to 400 Hz and install `i2c-tools`
    - Install NodeJS and NPM
        - Setup `archeyjs`
    - Setup `git` and `git-lfs`
    - Install dev tools: `build-essential`, `clang`, `cmake`, `pkg-config`, `python3-dev`

## Setting Up Ubuntu on RPi

```
curl -sSL https://raw.githubusercontent.com/MomsFriendlyRobotCompany/mote/master/ubuntu/setup.py | bash -
```
