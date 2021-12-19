FROM debian:bullseye-20211011
LABEL Vendor="OpenVPN" \
      maintainer="NineWoranop@users.noreply.github.com"

COPY script/install_openvpn.sh /install_openvpn.sh

RUN chmod +x /install_openvpn.sh;/install_openvpn.sh

EXPOSE 1194

# WORKDIR /etc/openvpn

# ENTRYPOINT ["/usr/sbin/openvpn", "--help"]
# CMD ["/usr/sbin/openvpn", "--config", "/etc/openvpn/server/server.conf"]
CMD nohup /usr/sbin/openvpn --config /etc/openvpn/server/server.conf & sleep infinity