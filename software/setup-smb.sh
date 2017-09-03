#!/bin/bash
set -e

# check if we are root
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit 1
fi

echo ""
echo "============================="
echo "| Setting Up Samba          |"
echo "============================="
echo ""

# just incase, install samba
apt-get -y install samba samba-common-bin

# samba setup
if [ -f "/etc/samba/smb.conf" ]; then
	mv /etc/samba/smb.conf /etc/samba/smb.bak
fi
cat <<EOF >/etc/samba/smb.conf
#======================= Global Settings =======================

[global]
   workgroup = WORKGROUP
   wins support = yes
   dns proxy = no

#### Debugging/Accounting ####
   log file = /var/log/samba/log.%m
   max log size = 1000
   syslog = 0
   panic action = /usr/share/samba/panic-action %d


####### Authentication #######

   server role = standalone server
   passdb backend = tdbsam
   obey pam restrictions = yes
   unix password sync = yes
   passwd program = /usr/bin/passwd %u
   passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
   pam password change = yes
   map to guest = bad user

############ Misc ############

# Allow users who've been granted usershare privileges to create
# public shares, not just authenticated ones
   usershare allow guests = yes

#======================= Share Definitions =======================

[pi]
   comment = Home Directories
   browseable = yes
   read only = no
   create mask = 0700
   directory mask = 0700
   valid users = %S
   path=/home/%S
EOF

smbpasswd -a pi
service smbd restart
service nmbd restart

echo ""
echo "*** samba is ready ***"
echo ""

# # samba setup
# if [ ! -f "/etc/samba/smb.bak" ]; then
# 	mv /etc/samba/smb.conf /etc/samba/smb.bak
# 	cp static/smb.conf /etc/samba
# 	smbpasswd -a pi
# 	service smbd restart
# 	service nmbd restart
#
# 	echo ""
# 	echo "*** samba is ready ***"
# 	echo ""
# else
# 	echo ""
# 	echo "*** samba appears to already be set up ***"
# 	echo ""
# fi

SCRIPT=$0

echo ""
echo "*** Done: ${SCRIPT} ***"
echo ""
