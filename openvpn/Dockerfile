FROM debian:bullseye-20211011
LABEL Vendor="OpenVPN" \
      maintainer="NineWoranop@users.noreply.github.com"

COPY script/*.sh /

RUN chmod +x /*.sh;/install_openvpn.sh

EXPOSE 1194

ENTRYPOINT ["/startup-openvpn.sh"]