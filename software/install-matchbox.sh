#!/bin/bash
#
# this sets up a lightweight X-server and window manager for graphical stuff
# pi-hole send a lot of info in the admin screen and consumes about 50% of the
# 4 core ... wtf?? this is a lot more than i expected. however, just looking at
# a simple static webpage, is very minimal ... 0-3% on the cores.

# check for root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo lcd_rotate=2 >> /boot/config.txt 

apt-get install -y --no-install-recommends xserver-xorg x11-xserver-utils xinit
apt-get install -y nodm matchbox-window-manager matchbox-keyboard ttf-mscorefonts-installer

mv /etc/default/nodm /home/pi

cat <<EOF >/etc/default/nodm
NODM_ENABLED=true
NODM_USER=pi
EOF

apt-get install --no-install-recommends chromium-browser -y

cat <<EOF>/home/pi/.xsession
#!/bin/bash
xset s off 
xset -dmps
xset s noblank
exec matchbox-window-manager  -use_titlebar no &
exec matchbox-keyboard &
chromium-browser --incognito -noerrdialogs http://pi-hole.local/admin/index.php http://plex.local:8080
EOF

# not sure why these appeared!!
rm -fr Music Public Videos Templates Pictures Documents Downloads Desktop

service nodm restart
