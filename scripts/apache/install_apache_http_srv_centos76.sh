#!/bin/bash

yum -y update
yum -y install gcc 

# install Apache HTTP 2.4.43
cd /usr/local/src
curl -O -k https://downloads.apache.org//httpd/httpd-2.4.43.tar.gz
tar -zxvf https://downloads.apache.org//httpd/httpd-2.4.43.tar.gz

cd httpd-2.4.43
./configure --prefix=/usr/local/apache
make && make install

# Start Apache HTTP
/usr/local/apache/bin/apachectl start

# Configuration folder
cd /usr/local/apache/conf

# Webroot folder
cd /usr/local/apache/htdocs