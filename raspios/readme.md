

## Run

```
ansible-playbook -i inventory.yml main.yml --vault-password-file ~/Dropbox/save/rpi-pki/ansible/key.txt
```

Get a dump of the gathered information about the system:

```
ansible -i inventory.yml dalek.local -m setup
```

---

"ansible_user_dir": "/home/pi",
"ansible_user_gid": 1000,
"ansible_user_id": "pi",
"ansible_user_shell": "/bin/bash",
"ansible_user_uid": 1000,

"ansible_architecture": "armv7l",
"ansible_architecture": "x86_64",

: {{ ansible_nodename }} {{ ansible_lsb.description }}

sshd_config validate: sshd -T -f %s

"ansible_distribution": "Debian",
"ansible_distribution_file_parsed": true,
"ansible_distribution_file_path": "/etc/os-release",
"ansible_distribution_file_variety": "Debian",
"ansible_distribution_major_version": "10",
"ansible_distribution_release": "buster",
"ansible_distribution_version": "10",


"ansible_env": {
    "HOME": "/home/pi",
    "LANG": "C",
    "LC_ALL": "C",
    "LC_NUMERIC": "C",
    "LOGNAME": "pi",
    "MAIL": "/var/mail/pi",
    "PATH": "/usr/local/bin:/usr/bin:/bin:/usr/games",
    "PWD": "/home/pi",
    "SHELL": "/bin/bash",
    "SHLVL": "0",
    "SSH_CLIENT": "fe80::1474:5cf6:a1b0:32bf%eth0 52447 22",
    "SSH_CONNECTION": "fe80::1474:5cf6:a1b0:32bf%eth0 52447 fe80::5c4b:b9f5:e2db:d531%eth0 22",
    "SSH_TTY": "/dev/pts/1",
    "TERM": "xterm-256color",
    "USER": "pi",
    "XDG_RUNTIME_DIR": "/run/user/1000",
    "XDG_SESSION_CLASS": "user",
    "XDG_SESSION_ID": "c38",
    "XDG_SESSION_TYPE": "tty",
    "_": "/bin/sh"
},

"ansible_lsb": {
    "codename": "buster",
    "description": "Raspbian GNU/Linux 10 (buster)",
    "id": "Raspbian",
    "major_release": "10",
    "release": "10"
},
"ansible_machine": "armv7l",
"ansible_machine_id": "6881c1c73c2e46a589a2d91da5830f20",


"ansible_nodename": "ultron",
"ansible_os_family": "Debian",
"ansible_pkg_mgr": "apt",


"ansible_proc_cmdline": {
    "8250.nr_uarts": "0",
    "bcm2708_fb.fbdepth": "16",
    "bcm2708_fb.fbheight": "416",
    "bcm2708_fb.fbswap": "1",
    "bcm2708_fb.fbwidth": "656",
    "coherent_pool": "1M",
    "console": [
        "ttyS0,115200",
        "tty1"
    ],
    "elevator": "deadline",
    "fsck.repair": "yes",
    "root": "PARTUUID=4b57c3cd-02",
    "rootfstype": "ext4",
    "rootwait": true,
    "snd_bcm2835.enable_compat_alsa": "0",
    "snd_bcm2835.enable_hdmi": "1",
    "snd_bcm2835.enable_headphones": "1",
    "vc_mem.mem_base": "0x3f000000",
    "vc_mem.mem_size": "0x3f600000"
},
"ansible_processor": [
    "0",
    "ARMv7 Processor rev 4 (v7l)",
    "1",
    "ARMv7 Processor rev 4 (v7l)",
    "2",
    "ARMv7 Processor rev 4 (v7l)",
    "3",
    "ARMv7 Processor rev 4 (v7l)"
],
"ansible_processor_cores": 1,
"ansible_processor_count": 4,
"ansible_processor_nproc": 4,
"ansible_processor_threads_per_core": 1,


## Atom Editor

Set tab size to 2 for yaml files, but 4 for python:

```cson
".python.source":
  editor:
    autoIndentOnPaste: true
    showIndentGuide: true
".yaml.source":
  editor:
    tabLength: 2
    showIndentGuide: true
```
