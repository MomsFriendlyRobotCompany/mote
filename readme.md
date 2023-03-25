![](pics/iron-man-legion.png)

# Mote

Some scripts to help setup Raspberry Pi images

## Ansible on Raspios

- `pi-basic-setup.yml`: setup a basic raspberry pi configuration ... **always run this first**
    - create user/password
    - setup ssh keys
    - setup python `venv` configuration called `py`
    - install `dotfiles` from github
- These all build on the basic setup playbook:
    - `pi-docker-setup.yml`: sets up a generic raspberry pi with docker
        - `get-docker.sh`: only downloads the script to `/tmp` ... you need to run it from there AND reboot
        - USB hard drive, set the UUID
        - installs docker yamls from github
    - `pi-USB-hd-setup.yml`: sets up a USB hard drive on the pi, you need a the UUID of the drive

```
ansible-playbook <ansible.yml>
```

## Setup Ansible in `venv`

```
python3 -m venv venvs/ansible
. ./venvs/ansible/bin/activate
pip install -U pip setuptools wheel ansible passlib
```

## Issues

- `docker.yml`: `get-docker.sh` must be run by hand ... double check `become: true` is set, might be a permissions problem
- `samba.yml`: can't set password, must be interactive

# MIT License

**Copyright (c) 2017 Kevin J. Walchko**

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
