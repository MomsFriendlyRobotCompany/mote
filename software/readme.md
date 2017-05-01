# Software

Here is an archive of software should you need to rebuild the microSD image

- microSD Image based off of Raspbian Jessie Lite 2017-04-10
- OpenCV 3.2 compiled for Raspbian
- python 3.6

## Setup

    sudo dpkg -i libopencv3.deb
    sudo dpkg -i python3.deb
    ./install.sh
    ./setup.sh

## Git

To setup `git`:

    git config --global push.default simple
    git config --global user.email "you@example.com"
    git config --global user.name "Your Name"
