FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    openssh-server \
    apache2 \
    net-tools \
    iputils-ping \
    traceroute \
    vim \
    nano \
    nmap \
    hping3 \
    iproute2 \
    iptables \
    tcpdump \
    pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

RUN echo 'root:root' | chpasswd 

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config

COPY index.html /var/www/html/

RUN echo "ip route add default via 10.5.0.1" >> /etc/bash.bashrc

EXPOSE 80
EXPOSE 22

CMD ip route del default via 10.5.0.254 && ip route add default via 10.5.0.1 && service ssh start && apachectl -D FOREGROUND