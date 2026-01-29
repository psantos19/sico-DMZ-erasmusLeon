#!/bin/bash
route del default gw 10.5.2.254
route add default gw 10.5.2.1

/usr/sbin/sshd -D
sed -i 's/\r$//' start.sh
chmod +x start.sh

# Start OpenVPN server
openvpn --config /etc/openvpn/server.conf