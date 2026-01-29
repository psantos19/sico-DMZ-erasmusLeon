#!/bin/bash
route del default gw 10.5.2.254
route add default gw 10.5.1.1

/usr/sbin/sshd -D
sed -i 's/\r$//' start.sh
chmod +x start.sh

service fail2ban start

google-authenticator -t -d -f -r 3 -R 30 -W
