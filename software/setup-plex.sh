#!/bin/bash

echo ""
echo "-------------------"
echo "| Setting up Plex |"
echo "-------------------"
echo ""


apt-get update
apt-get -y upgrade
apt-get -y install apt-transport-https

echo " > fixing apt sources.list"

wget -O - https://dev2day.de/pms/dev2day-pms.gpg.key  | sudo apt-key add -  
echo "deb https://dev2day.de/pms/ jessie main" | sudo tee /etc/apt/sources.list.d/pms.list

echo " > install plex media server "

apt-get update
# apt-get -y install -t jessie plexmediaserver
apt-get -y install plexmediaserver

echo " Done! "
echo " Make sure to edit /etc/default/plexmediaserver"
echo ""
