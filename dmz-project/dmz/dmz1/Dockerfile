FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    apache2 \
    openssh-server \
    curl \
    net-tools \
    vim \
    nano \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin no/' /etc/ssh/sshd_config \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
    && echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config \
    && echo "MaxAuthTries 2" >> /etc/ssh/sshd_config \
    && echo "Port 2222" >> /etc/ssh/sshd_config \
    && echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config

RUN useradd -m -s /bin/bash alumno && echo 'alumno:password' | chpasswd

RUN echo "SSH Server - Configured by Pedro" > /etc/issue.net

EXPOSE 80 2222

CMD service ssh start && apache2ctl -D FOREGROUND
