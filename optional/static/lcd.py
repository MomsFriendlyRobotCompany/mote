#!/usr/bin/env python3
# This is run using the system python, so just use python3
# make sure to install:
# pip install -U Adafruit-SSD1306 pillow netifaces psutil
# from __future__ import printfunction division
import netifaces as nf
import psutil as ps
import socket
import time
import Adafruit_GPIO.SPI as SPI
import Adafruit_SSD1306

from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw

# start ---
disp = Adafruit_SSD1306.SSD1306_128_32(rst=24)
disp.begin()

# Get display width and height.
width = disp.width
height = disp.height

# clear display ----
disp.clear()
disp.display()

# setup ---
# Create image buffer.
# Make sure to create image with mode '1' for 1-bit color.
image = Image.new('1', (width, height))

# Get drawing object to draw on image.
draw = ImageDraw.Draw(image)

# Draw a black filled box to clear the image.
draw.rectangle((0,0,width,height), outline=0, fill=0)

# Load default font.
font = ImageFont.load_default()

# https://github.com/sindresorhus/cli-spinners/blob/HEAD/spinners.json
spin = ['|','/','--','\\','+']
# spin = ["◴","◷","◶","◵"]
# spin = ["◐","◓","◑","◒"]
# spin = ["⠋","⠙","⠹","⠸","⠼","⠴","⠦","⠧","⠇","⠏"]
wrap = len(spin)
i = 0
x = 0
top = -2

try:
    while True:
        draw.rectangle((0,0,width,height), outline=0, fill=0)

        # get interfaces
        ifs = nf.interfaces()
        ap = False
        if 'wlan1' in ifs:
            addr = nf.ifaddresses('wlan0')[nf.AF_INET][0]['addr']
            if addr == '10.10.10.1':
                ap = True
        addrs = []
        for ip in ['en0', 'eth0', 'wlan0']:
            if ip in ifs:
                addr = nf.ifaddresses(ip)[nf.AF_INET][0]['addr']
                addrs.append((ip, addr,))

        str = "{} AP[{}] {}".format(
            socket.gethostname().split('.')[0],
            'UP' if ap else 'DOWN',
            spin[i%wrap]
        )
        # print(str)
        i += 1
        draw.text((x,top), str, font=font, fill=127)

        cpu = ps.cpu_percent()
        mem = ps.virtual_memory().percent
        str = "CPU: {:3.0f}% Mem: {:3.0f}%".format(cpu,mem)
        draw.text((x,top+8), str, font=font, fill=255)

        for cnt, (ip, addr) in enumerate(addrs):
            str = "{}: {}".format(ip, addr)
            draw.text((x,top+8+(cnt+1)*8), str, font=font, fill=255)

        disp.image(image); disp.display()
        time.sleep(1)
except KeyboardInterrupt:
    print('bye ...')

# clear display ----
disp.clear()
disp.display()

