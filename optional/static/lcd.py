#!/usr/bin/env python
from __future__ import printfunction division
import netifaces as nf
import psutil as ps
import socket
import time

# https://github.com/sindresorhus/cli-spinners/blob/HEAD/spinners.json
# spin = ['|','/','-','\\','+']
# spin = ["◴","◷","◶","◵"]
# spin = ["◐","◓","◑","◒"]
spin = ["⠋","⠙","⠹","⠸","⠼","⠴","⠦","⠧","⠇","⠏"]
wrap = len(spin)
i = 0
try:
    while True:
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

        print("{} AP[{}] {}".format(
            socket.gethostname().split('.')[0],
            'UP' if ap else 'DOWN',
            spin[i%wrap]
        ))
        i += 1

        cpu = ps.cpu_percent()
        mem = ps.virtual_memory().percent
        print("CPU: {:3.0f}% Mem: {:3.0f}%".format(cpu,mem))

        for ip, addr in addrs:
            print("{}: {}".format(ip, addr))
        time.sleep(1)
except KeyboardInterrupt:
    print('bye ...')
