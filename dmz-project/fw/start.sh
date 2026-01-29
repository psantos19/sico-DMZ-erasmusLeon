#!/bin/bash
LOGFILE="/start.log"

echo "Start script running" > "$LOGFILE"

sysctl -w net.ipv4.ip_forward=1 >> "$LOGFILE"

iptables -F
iptables -t nat -F
iptables -X
iptables -t nat -X
echo "Flushed iptables rules" >> "$LOGFILE"

if [ -f /etc/iptables/rules.v4 ]; then
    iptables-restore < /etc/iptables/rules.v4
    echo "Restored iptables rules from /etc/iptables/rules.v4" >> "$LOGFILE"
else
    echo "No /etc/iptables/rules.v4 file found; skipping restore" >> "$LOGFILE"
fi

service ssh start
echo "SSH service started" >> "$LOGFILE"

tail -f /dev/null
