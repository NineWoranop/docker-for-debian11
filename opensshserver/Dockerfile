FROM debian:bullseye-20211011
LABEL Vendor="OpenSSHServer" \
      maintainer="NineWoranop@users.noreply.github.com"

RUN apt-get update; apt-get install -y openssh-server;

# Verify package
#RUN dpkg-query -l | grep -i openssh-server

# Print version
RUN ssh -V

EXPOSE 22
