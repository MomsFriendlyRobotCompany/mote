#!/usr/bin/expect -f
spawn ssh-copy-id -p 2222 pi@dalek.local
expect "password:"
send "raspberry\n"
expect eof
