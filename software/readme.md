# Software Setup

These scripts are to help setup a new raspbian system. Once you `ssh` in, update the system:

    sudo apt-get update
    sudo apt-get -y upgrade
    sudo apt-get -y install git

Get a copy of this software one of two ways:

    mkdir github
    cd github
    git clone https://github.com/MomsFriendlyRobotCompany/mote.git # if you don't have write access to my repo
    git clone git@github.com:MomsFriendlyRobotCompany/mote.git     # if you are me

Now go into the software directory and install/setup everything:

    sudo ./install.sh
    sudo ./setup.sh <hostname> <wifi-ssid> <wifi-password>

Optional

    ./setup-git.sh <github-username>
    ./setup-smb.sh  # you will be asked for a SMB password, just use raspberry
    ./setup-ssh.sh

Note, this is **not** run as root

## Bypass known_hosts

Since all RPi's hostname are raspberrypi.local, it **sucks** when you try to connect
to a new one and you get the man-in-the-middle attack warning.

You can disable the check with:

    ssh -o UserKnownHostsFile=/dev/null pi@raspberrypi.local

### What is happending?

Both of the scripts `install.sh` and `setup.sh` are calling subscripts like
`install-python.sh`. Originally these were big monolithic scripts, but from time
to time, I only needed a part of the script. So now they are broken out, so if
all you need is to setup smb, just run the `setup-smb.sh` and you are done.
