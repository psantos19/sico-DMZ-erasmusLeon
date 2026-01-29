PEDRO SANTOS

Estrutura del Proyecto:

├── ca.crt
├── client.crt
├── client.key
├── client.ovpn
├── dmz
│   ├── dmz1
│   │   ├── authorized_keys
│   │   ├── Dockerfile
│   │   ├── fail2ban.local
│   │   ├── index.html
│   │   └── start.sh
│   └── dmz2
│       ├── authorized_keys
│       ├── Dockerfile
│       ├── fail2ban.local
│       ├── index.html
│       └── start.sh
├── docker-compose.yml
├── extranet
│   ├── Dockerfile
│   ├── index.html
│   └── start.sh
├── fw
│   ├── Dockerfile
│   └── start.sh
├── intranet
│   ├── int12
│   │   ├── Dockerfile
│   │   └── start.sh
│   └── int3
│       ├── Dockerfile
│       └── start.sh
├── ta.key
└── userdb.txt




IP ROUTES:

FW:
default via 10.5.1.254 dev eth0 
10.5.0.0/24 dev eth1 proto kernel scope link src 10.5.0.1 
10.5.1.0/24 dev eth0 proto kernel scope link src 10.5.1.1 
10.5.2.0/24 dev eth2 proto kernel scope link src 10.5.2.1 


EXT: 
default via 10.5.0.1 dev eth0 
10.5.0.0/24 dev eth0 proto kernel scope link src 10.5.0.20 

DMZ1:
default via 10.5.1.1 dev eth0 
10.5.1.0/24 dev eth0 proto kernel scope link src 10.5.1.20 

DMZ2:
default via 10.5.1.1 dev eth0 
10.5.1.0/24 dev eth0 proto kernel scope link src 10.5.1.21 

INT1:
default via 10.5.2.1 dev eth0 
10.5.2.0/24 dev eth0 proto kernel scope link src 10.5.2.20 

INT2:
default via 10.5.2.1 dev eth0 
10.5.2.0/24 dev eth0 proto kernel scope link src 10.5.2.21

INT3:
default via 10.5.2.1 dev eth0 
10.5.2.0/24 dev eth0 proto kernel scope link src 10.5.2.22 


FW RULES:

iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

iptables -A INPUT -p icmp -j ACCEPT
iptables -A OUTPUT -p icmp -j ACCEPT
iptables -A FORWARD -p icmp -j ACCEPT

iptables -A INPUT -i eth1 -p icmp -m limit --limit 1000/min -j ACCEPT

iptables -A FORWARD -i eth1 -o eth2 -j ACCEPT
iptables -A FORWARD -i eth2 -o eth1 -j ACCEPT

iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE

iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 22 -j DNAT --to-destination 10.5.1.20:2222

iptables -A FORWARD -p tcp -d 10.5.1.20 --dport 22 -j ACCEPT
iptables -A FORWARD -p tcp -d 10.5.1.20 --dport 2222 -j ACCEPT

iptables-save > /etc/iptables/rules.v4
