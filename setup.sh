#!/bin/bash -e

echo "\n-------------------------------------"
rm -f config
rm -f *.zip
rm -fr pi-gen
echo " Cleaning up old files: config, *.zip, pi-gen"
echo "-------------------------------------\n"

RELEASE="2020-02-13-raspbian-buster"
GH_PIGEN="https://github.com/RPi-Distro/pi-gen/archive/${RELEASE}.zip"
FOLDER="pi-gen-${RELEASE}"
UNZIP="${RELEASE}.zip"

if [[ $# -ne 3 ]]; then
    echo "Usage: ./setup.sh user_passwd wifi_ssid wifi_passwd"
    exit 1
else

USER_PASSWD=$1
WIFI_SSID=$2
WIFI_PASSWD=$3

cat << EOF >config
IMG_NAME="mote"
TARGET_HOSTNAME="mote"
FIRST_USER_PASS="${USER_PASSWD}"
DEPLOY_ZIP=1
LOCALE_DEFAULT="en_US.UTF-8"
KEYBOARD_KEYMAP="us"
KEYBOARD_LAYOUT="English (US)"
ENABLE_SSH=1
STAGE_LIST="stage0 stage1 stage2 kevin robot"
WPA_ESSID="${WIFI_SSID}"
WPA_PASSWORD="${WIFI_PASSWD}"
WPA_COUNTRY="US"
EOF

fi


wget -c ${GH_PIGEN}
unzip ${UNZIP}
mv "${FOLDER}" pi-gen
cp -R kevin pi-gen/
cp -R robot pi-gen/

cp config pi-gen/

cd pi-gen/
rm -fr stage3 stage4 stage5 export-noobs
rm stage2/EXPORT_NOOBS
rm stage2/EXPORT_IMAGE

echo "================================================"
echo " Now run \"./build-docker.sh\" in pi-gen "
echo " if there is an error, continue with \"CONTINUE=1 ./build-docker.sh\" "
echo ""
echo " The final image is in the \"deploy\" folder"
echo "================================================"
echo ""
