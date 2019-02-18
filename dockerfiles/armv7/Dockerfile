FROM arm32v6/alpine:latest

COPY scripts/*.sh /usr/local/bin/
COPY files/known_hosts /root/.ssh/

# hack to force system to upgrade to armv7
COPY dockerfiles/armv7/arch /etc/apk/
RUN apk -U upgrade -a

ENTRYPOINT [ "/bin/sh" ]
