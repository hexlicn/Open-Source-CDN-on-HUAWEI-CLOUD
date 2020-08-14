#!/bin/bash

modprove -l | grep ipvs

yum -y install ipvsadm

# set kernel params
echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.send_redirects = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.send_redirects = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.eth0.send_redirects = 1" >> /etc/sysctl.conf

# active lernel params
sysctl -p

# add vip by ifconfig or nmcli
ifconfig eth0:0 182.16.0.50 netmask 255.255.255.255 broadcast 172.16.0.50 up
route add -host 172.16.0.50 dev eth0:0

# setup lvs
ipvsadm -A -t 172.16.0.50:80 -s rr
ipvsadm -a -t 172.16.0.50:80 -r 172.16.0.12 -g
ipvsadm -a -t 172.16.0.50:80 -r 172.16.0.13 -g

# set kernel params for real server squid-1 and squid-2
echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.lo.arp_ignore = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.lo.arp_announce = 2" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.arp_ignore = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.arp_announce = 2" >> /etc/sysctl.conf

# active settings
sysctl -p

# setup vip for real server squid-1 and squid-2 which for dr mode
ifconfig lo:0 172.16.0.50 netmask 255.255.255.255 broadcast 172.16.0.50 up
route add -host 172.16.0.50 dev lo:0

# check lvs status
ipvsadm -l