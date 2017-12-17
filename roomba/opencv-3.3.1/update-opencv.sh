#!/usr/bin/env bash

apt-get -y upgrade
apt-get -y install build-essential cmake git pkg-config python-dev swig
apt-get -y install libeigen3-dev
apt-get -y install ffmpeg
apt-get -y install libjpeg-dev libtiff5-dev libjasper-dev libpng-dev libpng-tools
apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
apt-get -y --force-yes install libxvidcore-dev libx264-dev
apt-get -y install libatlas-base-dev gfortran
apt-get -y install python2.7-dev python3-dev
apt-get -y install libgtk2.0-dev
apt-get autoremove -y

# old
# apt-get -y install build-essential cmake git pkg-config python-dev swig
# apt-get -y install libeigen3-dev
# apt-get -y install ffmpeg
# apt-get -y install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
# apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
# apt-get -y install libxvidcore-dev libx264-dev
# apt-get -y install libatlas-base-dev gfortran
# apt-get -y install python2.7-dev
# apt-get -y install libgtk2.0-dev

