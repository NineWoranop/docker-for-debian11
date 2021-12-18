FROM debian:bullseye-20211011
LABEL Vendor="Jython" \
      maintainer="NineWoranop@users.noreply.github.com"

RUN apt-get update; apt-get install -y curl; \
    curl -O http://ftp.tw.debian.org/debian/pool/main/o/openjdk-8/openjdk-8-jre-headless_8u302-b08-1_amd64.deb; \
    curl -O http://ftp.tw.debian.org/debian/pool/main/o/openjdk-8/openjdk-8-jdk-headless_8u302-b08-1_amd64.deb; \
    dpkg -i --force-all \
    openjdk-8-jre-headless_8u302-b08-1_amd64.deb \
    openjdk-8-jdk-headless_8u302-b08-1_amd64.deb \
    || true && \
    rm -rf *.deb;

RUN apt --fix-broken install -y && apt-get install -y python2.7 python-dev jython
