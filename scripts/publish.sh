#!/bin/sh

ARCH="$(apk --print-arch)"
PR="$DRONE_PULL_REQUEST"
REPO="$DRONE_REPO"
HOST=ua.alpinelinux.org

apk -U add rsync openssh-client mosquitto-clients
(umask 077; echo "$SSH_KEY" > "$HOME"/.ssh/id_ed25519)
ssh buildozer@$HOST "mkdir -p packages/$REPO/$PR/$ARCH"
rsync -av --delete-after /home/buildozer/drone/packages/*/$ARCH/*.apk \
	buildozer@$HOST:packages/$REPO/$PR/$ARCH/
mosquitto_pub -h msg.alpinelinux.org -p 8883 --cafile /etc/ssl/cert.pem \
	-u user-aports -P "$MQTT_PASS" \
	-t "user-aports" -m "{\"pr\": \"$PR\", \"arch\": \"$ARCH\", \"repo\": \"$REPO\"}"
