FROM neomediatech/ubuntu-base:latest

ENV VERSION=0.10.5 \
    SERVICE=fail2ban \
    FAIL2BAN_VERSION=0.10.5

LABEL maintainer="docker-dario@neomediatech.it" \ 
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-type=Git \
      org.label-schema.vcs-url=https://github.com/Neomediatech/${SERVICE} \
      org.label-schema.maintainer=Neomediatech

RUN apt update && apt-get -y dist-upgrade && \
    apt-get install -y --no-install-recommends ca-certificates python3 python-setuptools \
    python3-pycurl wget ipset iptables ssmtp redis-tools curl whois && \
    rm -rf /var/lib/apt/lists* && \
    rm -rf /etc/fail2ban/jail.d && \
    mkdir -p /var/run/fail2ban && \
    cd /tmp && \
    wget https://github.com/fail2ban/fail2ban/archive/${FAIL2BAN_VERSION}.tar.gz -O fail2ban-${FAIL2BAN_VERSION}.tar.gz && \
    tar xvzf fail2ban-${FAIL2BAN_VERSION}.tar.gz && \
    cd fail2ban-${FAIL2BAN_VERSION} && \
    python setup.py install && \
    cd / && \
    mkdir -p /usr/local/etc/fail2ban && \
    cp -rp /etc/fail2ban /usr/local/etc && \
    rm -rfv /tmp/*

    
COPY entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

VOLUME [ "/data" ]

ENTRYPOINT [ "/tini", "--", "/entrypoint.sh" ]
CMD [ "fail2ban-server", "-f", "-x", "-v", "start" ]

HEALTHCHECK --interval=30s --timeout=5s CMD fail2ban-client ping
