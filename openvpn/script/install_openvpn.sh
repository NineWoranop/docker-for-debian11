apt-get update
apt-get install -y openvpn easy-rsa
cd /usr/share/easy-rsa
./easyrsa init-pki
./easyrsa --batch build-ca nopass
./easyrsa --batch gen-req vpn-server nopass
./easyrsa --batch sign-req server vpn-server
./easyrsa --batch gen-req vpn-client01 nopass
./easyrsa --batch sign-req client vpn-client01
./easyrsa gen-dh
openvpn --genkey secret /etc/openvpn/server/ta.key
# echo -e "-----BEGIN OpenVPN Static key V1-----\n\
# c926675f4df0c07b9ac1d390bcfa4507\n\
# b2a588dddbfb23ac26253be39d2adfe2\n\
# 868bc19373ea449e981d25b2f8b41f87\n\
# ba8c28b3180ffc9c7efea41ec12484eb\n\
# 362309455f2b621d778a1ac82deae791\n\
# 12447425176b742243f04b84df5c83f5\n\
# 372f9cd6283415083cb76a4ffd4bfe10\n\
# e4d9fdd32820ff92441bf3f0290bbf62\n\
# 7c0d5c55a6fc3c68ab792f4e848f375e\n\
# fe7012bfbe355814393ffed600053e2f\n\
# 5f67bf9c54075e9504520b0ff421c48e\n\
# dfd258cb7cd63353fde8aaef69e934bb\n\
# 5d8be8394d6fad94895bfc8bb6ff9969\n\
# 43f585605d6cbfcd7609033e020ad3a0\n\
# bce1def3246900261c5a7750f26109a3\n\
# 860f00d2dddaebb827632cd1010b0a2b\n\
# -----END OpenVPN Static key V1-----" > /etc/openvpn/server/ta.key
# Configure VPN
echo -e "# OpenVPN Port, Protocol and the Tun\n\
port 1194\n\
proto tcp\n\
dev tun\n\
\n\
# OpenVPN Server Certificate - CA, server key and certificate\n\
ca /etc/openvpn/server/ca.crt\n\
cert /etc/openvpn/server/vpn-server.crt\n\
key /etc/openvpn/server/vpn-server.key\n\
\n\
#DH and CRL key\n\
dh /etc/openvpn/server/dh.pem\n\
\n\
server 10.8.0.0 255.255.255.0\n\
push redirect-gateway def1\n\
\n\
# Publish your vpn to DNS by used Google's DNS\n\
push dhcp-option DNS 8.8.8.8\n\
push dhcp-option DNS 8.8.4.4\n\
\n\
# TLS Security\n\
cipher AES-256-GCM\n\
tls-version-min 1.2\n\
tls-cipher TLS-DHE-RSA-WITH-AES-256-GCM-SHA384:TLS-DHE-RSA-WITH-AES-128-GCM-SHA256\n\
auth SHA512\n\
auth-nocache\n\
tls-auth /etc/openvpn/server/ta.key 0\n\
#tls-crypt myvpn.tlsauth\n\
\n\
# Other Configuration\n\
keepalive 20 60\n\
user nobody\n\
group nogroup\n\
persist-key\n\
persist-tun\n\
;comp-lzo yes\n\
\n\
# OpenVPN Log\n\
status /var/log/openvpn/openvpn-status.log\n\
log-append /var/log/openvpn/openvpn.log\n\
verb 3\n\
\n\
;explicit-exit-notify 1\n\
;daemon" > /etc/openvpn/server/server.conf 
#Copy configuration for VPN server
cp pki/dh.pem /etc/openvpn/server/
cp pki/ca.crt /etc/openvpn/server/
cp pki/issued/vpn-server.crt /etc/openvpn/server/
cp pki/private/vpn-server.key /etc/openvpn/server/
#Copy vpn-client01 Key and Certificate.
cp pki/ca.crt /etc/openvpn/client/
cp pki/issued/vpn-client01.crt /etc/openvpn/client/
cp pki/private/vpn-client01.key /etc/openvpn/client/
cp /etc/openvpn/server/ta.key /etc/openvpn/client/
