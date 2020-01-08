FROM neomediatech/ubuntu-base:latest

ENV VERSION=0.10.2-2 \
    DEBIAN_FRONTEND=noninteractive \
    SERVICE=fail2ban

LABEL maintainer="docker-dario@neomediatech.it" \ 
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-type=Git \
      org.label-schema.vcs-url=https://github.com/Neomediatech/${SERVICE} \
      org.label-schema.maintainer=Neomediatech

RUN apt update && apt -y dist-upgrade && \
    apt install -y --no-install-recommends fail2ban ipset iptables ssmtp redis-tools curl && \
    rm -rf /var/lib/apt/lists* && \
    rm -rf /etc/fail2ban/jail.d && \
    mkdir -p /var/run/fail2ban
    
COPY entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

VOLUME [ "/data" ]

ENTRYPOINT [ "/tini", "--", "/entrypoint.sh" ]
CMD [ "fail2ban-server", "-f", "-x", "-v", "start" ]

HEALTHCHECK --interval=30s --timeout=5s CMD fail2ban-client ping
