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
cat <<EOF >> /etc/openvpn/server/server.conf 
# OpenVPN Port, Protocol and the Tun
port 1194
proto tcp
dev tun

# OpenVPN Server Certificate - CA, server key and certificate
ca /etc/openvpn/server/ca.crt
cert /etc/openvpn/server/vpn-server.crt
key /etc/openvpn/server/vpn-server.key

#DH and CRL key
dh /etc/openvpn/server/dh.pem

server 10.8.0.0 255.255.255.0
push "redirect-gateway def1"

# Publish your vpn to DNS by used Google's DNS
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"

# TLS Security
cipher AES-256-GCM
tls-version-min 1.2
tls-cipher TLS-DHE-RSA-WITH-AES-256-GCM-SHA384:TLS-DHE-RSA-WITH-AES-128-GCM-SHA256
auth SHA512
auth-nocache
tls-auth /etc/openvpn/server/ta.key 0
#tls-crypt myvpn.tlsauth

# Other Configuration
keepalive 20 60
user nobody
group nogroup
persist-key
persist-tun
;comp-lzo yes

# OpenVPN Log
status /var/log/openvpn/openvpn-status.log
log-append /var/log/openvpn/openvpn.log
verb 3

;explicit-exit-notify 1
;daemon
EOF
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
# mkdir -p /dev/net
# if [ ! -c /dev/net/tun ]; then
#     mknod /dev/net/tun c 10 200
#     chmod 600 /dev/net/tun
# fi
