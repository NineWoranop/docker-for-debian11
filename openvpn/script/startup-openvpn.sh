#!/bin/bash
mkdir -p /dev/net
if [ ! -c /dev/net/tun ]; then
    mknod /dev/net/tun c 10 200
    chmod 600 /dev/net/tun
fi
/usr/sbin/openvpn --config /etc/openvpn/server/server.conf

echo "exited shell script $0"