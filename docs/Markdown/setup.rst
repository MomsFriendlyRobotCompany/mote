Setup
=========

Follow the instructions to install Rasbian Jessie-lite from `here <https://www.raspberrypi.org/documentation/installation/installing-images/mac.md>`_

1. Run ``df -h`` to find the disk, pretend it is ``/dev/disk3s1`` for these steps
2. ``sudo diskutil unmount /dev/disk3s1``
3. ``sudo dd bs=1m if=2017-03-02-raspbian-jessie.img of=/dev/rdisk3``

For Windoz, use `these instructions <https://www.raspberrypi.org/documentation/installation/installing-images/windows.md>`_

Before Booting Rasbian
-----------------------

You need to make a couple more changes before you put the SD card into the Pi.

In config.txt, add the following to the bottom::

  dtoverlay=dwc2

In cmdline.txt, add this right after rootwait::

  modules-load=dwc2,g_ether

SSH Off by Default
---------------------

The boot partition on a Pi should be accessible from any 
machine with an SD card reader, on Windows, Mac, or Linux. 
If you want to enable SSH, all you need to do is to put a 
file called ssh in the /boot/ directory. The contents of 
the file don’t matter: it can contain any text you like, 
or even nothing at all. When the Pi boots, it looks for 
this file; if it finds it, it enables SSH and then deletes 
the file.

You can simply do::

  cd /boot
  touch ssh

Now SSH will work.

Boot Linux
------------

Now insert the SD card into the Zero and boot linux. From a latop, type::

  ssh pi@raspberrypi.local

Then do::

  sudo apt update
  sudo apt upgrade


References
==============

- `Adafruit ethernet gadget setup <https://learn.adafruit.com/turning-your-raspberry-pi-zero-into-a-usb-gadget/ethernet-gadget>`_
- 
