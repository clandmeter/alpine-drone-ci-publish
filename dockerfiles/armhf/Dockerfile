FROM arm32v6/alpine:latest

COPY scripts/*.sh /usr/local/bin/
COPY files/known_hosts /root/.ssh/

ENTRYPOINT [ "/bin/sh" ]
