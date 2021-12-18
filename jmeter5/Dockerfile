FROM debian:bullseye-20211011
LABEL Vendor="JMeter5.4.1" \
      maintainer="NineWoranop@users.noreply.github.com"

RUN apt-get update; apt-get install -y curl; \
    curl -O http://ftp.tw.debian.org/debian/pool/main/o/openjdk-8/openjdk-8-jre-headless_8u302-b08-1_amd64.deb; \
    curl -O http://ftp.tw.debian.org/debian/pool/main/o/openjdk-8/openjdk-8-jdk-headless_8u302-b08-1_amd64.deb; \
    dpkg -i --force-all \
    openjdk-8-jre-headless_8u302-b08-1_amd64.deb \
    openjdk-8-jdk-headless_8u302-b08-1_amd64.deb \
    || true && \
    rm -rf *.deb;

RUN cd /home; \
    curl -O https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-5.4.1.tgz; \
	tar -xvzf apache-jmeter-5.4.1.tgz; \
    rm -rf *.tgz; \
	mv apache-jmeter-5.4.1 jmeter; \
	cd /home/jmeter/bin; \
	rm -rf /home/jmeter/lib/log4j-*.jar; \
    printf '\n' | ./create-rmi-keystore.sh -dname 'CN=jmeter';
#    cp rmi_keystore.jks /home/jmeter/bin/;

COPY jmeter-prometheus-plugin-0.6.0.jar /home/jmeter/lib/ext/jmeter-prometheus-plugin-0.6.0.jar

COPY log4j-*.jar /home/jmeter/lib/

WORKDIR /home/jmeter/bin

EXPOSE 1099

# -s, --server
#                run the JMeter server
# -n, --nongui
#                run JMeter in nongui mode
# -J, --jmeterproperty {argument}={value}
#                Define additional JMeter properties
CMD ["-s", \
     "-n", \
	 "-Jserver.rmi.port=1099", \
	 "-Jserver.rmi.ssl.disable=true" \
]

ENTRYPOINT ["/home/jmeter/bin/jmeter"]