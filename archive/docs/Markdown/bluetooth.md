# Bluetooth Low Energy

[Ref](https://www.domoticz.com/wiki/Presence_detection_(Bluetooth_4.0_Low_energy_Beacon))


# Installation instructions

The script is hosted here : https://github.com/jmleglise/mylittle-domoticz/

Bluez - the linux bluetooth stack

Bluez requires a 3.5+ kernel
First install Dependencies that the bluez library uses.

   sudo apt-get update
   sudo apt-get install -y libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev

And BLE need a >5.3 bluez stack version.

    sudo apt-get install bluez 

## Build

But now, the available version is under 5.3, then you must compile from the source.
Check the last version here : http://www.kernel.org/pub/linux/bluetooth/ (and change the filename below accordingly. 
Mine was 5.39 ). The compilation take around 20 minutes and at the end, you will need to reboot.

    sudo mkdir bluez ; cd bluez ; sudo wget http://www.kernel.org/pub/linux/bluetooth/bluez-5.39.tar.xz
    sudo tar -xJf bluez-5.39.tar.xz ; cd bluez-5.39 ; sudo ./configure --disable-systemd ; sudo make ; sudo make install ; sudo apt-get install python-bluez python-requests
    sudo cp attrib/gatttool /usr/local/bin/
    sudo shutdown -r now

TODO check the right of gatttool. (set execution right chmod +x ?) 

# First Test

To ensure the USB Bluetooth device is being seen, run `lsusb`, the result will look like this:

    Bus 001 Device 002: ID 0424:9514 Standard Microsystems Corp.
    Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
    Bus 001 Device 003: ID 0424:ec00 Standard Microsystems Corp.
    Bus 001 Device 004: ID 04d8:f55e Microchip Technology, Inc.
    Bus 001 Device 005: ID 0403:6001 Future Technology Devices International, Ltd FT232 USB-Serial (UART) IC
    Bus 001 Device 006: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)

For me, the adapter is the one on Bus 001 Device 006, close by my audio card, RFXCOM, USB relay card ... To show more information about it, do:

sudo lsusb -v -d 0a12:
If this is working, run the hciconfig tool:
pi@raspberrypi ~ $ hciconfig
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 00:02:72:14:27:0E  ACL MTU: 1021:8  SCO MTU: 64:1
	DOWN 
	RX bytes:2715 acl:1 sco:0 events:146 errors:0
	TX bytes:2500 acl:0 sco:0 commands:133 errors:0
!!!  The python script will work only if your adapter is on hci0:  If not, you will have to adapt the script !!!

Get this test script :

wget https://raw.githubusercontent.com/jmleglise/mylittle-domoticz/master/Presence-detection-beacon/test_beacon.py
sudo python test_beacon.py
It shall activate the hci0 port, and detect all beacons around. It's important to note the MAC Address and the frequency with which the beacon emits, in order to understand what happened next

Install Script
sudo wget https://raw.githubusercontent.com/jmleglise/mylittle-domoticz/master/Presence-detection-beacon/check_beacon_presence.py
sudo mv check_beacon_presence.py /usr/local/bin/
sudo chmod 755 /usr/local/bin/check_beacon_presence.py
Edit the script
(Read the comment in the script)

Log
- For manual launch and testing, display Log to console with debug verbose
logLevel=logging.DEBUG
#logLevel=logging.CRITICAL
#logOutFilename='/var/log/check_beacon_presence.log'
- For production : log in file, only critical
#logLevel=logging.DEBUG
logLevel=logging.CRITICAL
logOutFilename='/var/log/check_beacon_presence.log'
Beacon Data
Configure your Beacons in the TAG_DATA table with : [Name,MacAddress,Timeout,0,idx,mode]
- Name : the strictly exact name of the uservariable used in Domoticz. Case sensitive !
- macAddress : of the beacon. Case insensitive
- Timeout is in seconds the elapsed time without a detection for switching the beacon AWAY. Ie :if your beacon emits every 3 to 8 seconds usually, a timeout of 15 seconds seems good.
- 0 : used by the script (will keep the time of the last broadcast) 
- idx of the uservariable in Domoticz for this beacon
mode : SWITCH_MODE = One update per status change / REPEAT_MODE = continuous updating the RSSI every 3 seconds
TAG_DATA = [  
            ["Tag_Orange","Fb:14:78:38:18:5e",15,0,6,REPEAT_MODE],
            ["Tag_Green","ff:ff:60:00:22:ae",15,0,7,REPEAT_MODE]
           ]
Domoticz :
Change your IP and Port here : 
For the most common case, you use your localhost

 URL_DOMOTICZ = 'http://localhost:8080/json.htm?type=command&param=updateuservariable&idx=PARAM_IDX&vname=PARAM_NAME&vtype=2&vvalue=PARAM_CMD'
 DOMOTICZ_USER=''
 DOMOTICZ_PASS=''
Or for those who have strengthened their installation with SSL, certificate, password ...

 URL_DOMOTICZ = 'https://domain.com:XXXX/json.htm?type=command&param=updateuservariable&idx=PARAM_IDX&vname=PARAM_NAME&vtype=2&vvalue=PARAM_CMD'
 DOMOTICZ_USER='xxxxxxx'
 DOMOTICZ_PASS='xxxxxxx'

Second Test : Run the script manually
sudo python /usr/local/bin/check_beacon_presence.py
The output will be displayed on screen , or in log file according to the parameter in the script:
Display the log file with : 
sudo more /var/log/check_beacon_presence.log
If uservariables are updating correctly, go head with the installation and edit the script to log to file.

Autorun as a service
And now the installation of the service (and auto run at start of the raspberryPi)

It Depends of your system. Do you use wheezy or jessie ? Check with :

echo $(lsb_release -is) $(lsb_release -cs) $(lsb_release -rs)

Method 1 for Debian wheezy system
sudo wget https://raw.githubusercontent.com/jmleglise/mylittle-domoticz/master/Presence-detection-beacon/check_beacon_presence
sudo mv check_beacon_presence /etc/init.d/
sudo chmod 755 /etc/init.d/check_beacon_presence

Check with starting the service manually : 
sudo /etc/init.d/check_beacon_presence start
Check with :
sudo /etc/init.d/check_beacon_presence status
other commands : start, stop, restart, status
And Finally, register the service to autorun the script when the Raspberry Start :
sudo update-rc.d check_beacon_presence defaults
Memo removing the autorun :
sudo update-rc.d -f check_beacon_presence remove
Method 2 for Debian jessie system (thanks to justin81)
The autostart has to be modified to use systemctl instead of the update-rc.d method to run at the end of all initializations.


sudo nano /lib/systemd/system/check_beacon_presence.service

Paste:

[Unit]
Description=check_beacon_presence Service
After=multi-user.target
 
[Service]
User=root
Type=idle
ExecStart=/usr/local/bin/check_beacon_presence.py
 
[Install]
WantedBy=multi-user.target
run:

sudo chmod 644 /lib/systemd/system/check_beacon_presence.service
sudo systemctl daemon-reload
sudo systemctl enable check_beacon_presence.service
sudo reboot
Check if it is running:

sudo systemctl status check_beacon_presence.service -l
Final test
(with autorun enabled)
sudo reboot
ps -ef | grep python
You should get check_beacon_presence.py running
Use in Domoticz
Lua
Write script based on the uservariable. 
For using user variables in Lua scripts, there are three tables available: uservariables, uservariables_lastupdate and uservariablechanged. The uservariablechanged table (with only the variable that triggered the event) is only available in your event scripts (script_variable_name.lua), the other two are always available. Reference your variable by name, e.g. if uservariables["MyVar"] = ... Have a look here : https://www.domoticz.com/wiki/Events
For example a variable script : 
script_variable_autoArmAlarm.lua

--Variable scripts receive 7 tables from Domoticz: 
-- otherdevices, otherdevices_lastupdate, otherdevices_svalues, otherdevices_idx, uservariables, uservariables_lastupdate and uservariablechanged
 
commandArray = {}
 
beaconHome=0
for variableName, variableValue in pairs(uservariables) do
    if string.sub(variableName,1,3)=="Tag" and variableValue ~= "AWAY" then
      beaconHome=beaconHome+1
    end
end
if otherdevices['Alarm'] == 'On' and beaconHome>=1 then   -- switch Off Alarm because 1 beacon come back Home
    table.insert (commandArray, { ['Alarm'] ='Off' } )
elseif otherdevices['Alarm'] == 'Off' and beaconHome==0 then  -- switch On Alarm because all beacon are away
    table.insert (commandArray, { ['Alarm'] ='On' } )
end
 
return commandArray
Other example on the forum topic : https://www.domoticz.com/forum/viewtopic.php?f=28&t=10640&start=100#p86310
Blocky
https://www.domoticz.com/forum/viewtopic.php?f=28&t=10640&start=140#p86725
References
The forum topic about this script is here:https://www.domoticz.com/forum/viewtopic.php?f=28&t=10640
Review page for ble beacons : https://www.beaconzone.co.uk/allbeacons 
https://wiki.tizen.org/wiki/Bluetooth
https://storage.googleapis.com/google-code-archive-source/v2/code.google.com/pybluez/source-archive.zip => pybluez\examples\advanced\inquiry-with-rssi.py
Other command
Reset the bluetooth adapter (hci0 in the above example) with:
sudo hciconfig hci0 down
sudo hciconfig hci0 up
Find the MacAdress of your beacon with hcitool (from bluez installation)

  pi@raspberrypi ~ $ whereis hcitool
  hcitool: /usr/local/bin/hcitool
  pi@raspberrypi ~ $ sudo hcitool lescan
  LE Scan ...
  FB:14:78:38:18:5E nut
  FB:14:78:38:18:5E (unknown)
