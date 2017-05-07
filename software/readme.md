# Software

Here is an archive of software should you need to rebuild the microSD image

- microSD Image based off of Raspbian Jessie Lite 2017-04-10
- OpenCV 3.2 compiled for Raspbian
- python 3.6

## Bypass known_hosts

Since all RPi's hostname are raspberrypi.local, it **sucks** when you try to connect
to a new one and you get the man-in-the-middle attack warning.

You can disable the check with:

	ssh -o UserKnownHostsFile=/dev/null pi@raspberrypi.local

## Setup

Once you `ssh` in, update the system:

    sudo apt-get update
    sudo apt-get -y upgrade
    sudo apt-get -y install git

Get a copy of this software one of two ways:

    mkdir github
    cd github
    git clone https://github.com/walchko/mote.git # if you don't have write access to my repo
    git clone git@github.com:walchko/mote.git  # if you are me

Now go into the software directory and install/setup everything:

    cd mote/software
    ./install.sh
    ./setup.sh

## Git

To setup `git` so you can work with something like bitbucket or github:

    git config --global push.default simple
    git config --global user.email "you@example.com"
    git config --global user.name "Your Name"
