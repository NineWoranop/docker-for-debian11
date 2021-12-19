FROM debian:bullseye-20211011
LABEL Vendor="OpenVPN" \
      maintainer="NineWoranop@users.noreply.github.com"

COPY script/*.sh /

RUN chmod +x /*.sh;/install_openvpn.sh

EXPOSE 1194

# WORKDIR /etc/openvpn

ENTRYPOINT ["startup-openvpn.sh"]

# ENTRYPOINT ["openvpn", "--config", "/etc/openvpn/server/server.conf"]
# CMD ["/usr/sbin/openvpn", "--config", "/etc/openvpn/server/server.conf"]
# CMD nohup /usr/sbin/openvpn --config /etc/openvpn/server/server.conf & sleep infinity
# CMD /usr/sbin/openvpn --config /etc/openvpn/server/server.conf
# CMD /usr/sbin/openvpn --config /etc/openvpn/server/server.conf & tail -f /var/log/openvpn/openvpn.log