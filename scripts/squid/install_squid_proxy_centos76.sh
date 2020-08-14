#！/bin/bash

yum -y groupinstall "development tools"

cd /usr/local/src/
curl -O -k http://www.squid-cache.org/Versions/v5/squid-5.0.3.tar.gz

tar zxvf squid-5.0.3.tar.gz
cd squid-5.0.3
./configure --prefix=/usr/local/squid
make && make install 

#Create cache folder
/usr/local/squid/sbin/squid -z

#Change permission
chmod 777 /usr/loca/squid/var/logs

#Start squid
/usr/local/squid/sbin/squid

#Stop squid
/usr/local/squid/sbin/squid -k shutdown

#Configuration folder
ll /usr/local/squid/etc/squid.conf

#Edit and Check
/usr/local/squid/sbin/squid -k parse
/usr/local/squid/sbin/squid -k reconfigure

#Clear cache
/usr/local/squid/sbin/squid/squidclient -p 80 "http://172.16.0.11"