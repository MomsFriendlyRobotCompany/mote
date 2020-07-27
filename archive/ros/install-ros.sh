#!/bin/bash
# http://wiki.ros.org/melodic/Installation/Ubuntu

echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list
apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
apt-get update
# apt-get install ros-melodic-desktop-full -y
# apt-get install ros-melodic-desktop -y
apt-get install ros-melodic-ros-base -y
rosdep init
rosdep update
#echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
#source ~/.bashrc
apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential
