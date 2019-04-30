FROM alpine:3.9

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL maintainer="Dario <docker-dario@neomediatech.it>" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="fail2ban" \
  org.label-schema.description="Fail2ban" \
  org.label-schema.version=$VERSION \
  org.label-schema.url="https://github.com/Neomediatech/docker-fail2ban" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/Neomediatech/docker-fail2ban" \
  org.label-schema.vendor="Dario" \
  org.label-schema.schema-version="1.0"

ARG FAIL2BAN_VERSION=0.10.4

RUN apk update && apk upgrade && \
    apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/Europe/Rome /etc/localtime && \
    apk add --no-cache tini bash ipset iptables ssmtp fail2ban redis curl && \
    rm -rf /usr/local/share/doc /usr/local/share/man /var/cache/apk/* /tmp/* /etc/fail2ban/jail.d
    
COPY entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

VOLUME [ "/data" ]

ENTRYPOINT [ "/sbin/tini", "--", "/entrypoint.sh" ]
CMD [ "fail2ban-server", "-f", "-x", "-v", "start" ]

HEALTHCHECK --interval=10s --timeout=5s CMD fail2ban-client ping
