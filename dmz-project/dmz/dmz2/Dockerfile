FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    apache2 \
    openssh-server \
    curl \
    fail2ban \
    libpam-google-authenticator \
    net-tools \
    iputils-ping \
    traceroute \
    vim \
    nano \
    nmap\
    iproute2 \
    iptables \
    pkg-config \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config

COPY index.html /var/www/html/index.html

EXPOSE 80 22

CMD service ssh start && apache2ctl -D FOREGROUND