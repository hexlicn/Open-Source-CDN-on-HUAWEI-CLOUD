#!/bin/bash

# install pcre library
curl -O -k https://tenet.dl.sourceforge.net/project/pcre/pcre/8.44/pcre-8.44.tar.bz2
tar jxvf pcre-8.44.tar.bz2
cd pcre-8.44
./configure --enable-utf8
make && make intall
pcre-config --version

# install Nginx
yum -y install -y make zlib zlib-devel openssl openssl-devel gcc-c++ libtool
curl -O -k https://nginx.org/download/nginx-1.19.2.tar.gz
useradd -s /sbin/nologin nginx
tar xf nginx-1.19.2.tar.gz
cd nginx-1.19.2
./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre=/usr/local/src/pcre-8.44 --user=nginx --group=nginx
make && make install
/usr/local/nginx/sbin/nginx -V

# check configuration
/usr/local/nginx/sbin/nginx -t

# start nginx
/usr/local/nginx/sbin/nginx

# reload configuration
/usr/local/nginx/sbin/nginx -s reload

# restart nginx
/usr/local/nginx/sbin/nginx -s reopen

# shutdowm immediate
/usr/local/nginx/sbin/nginx -s stop

# shutdown normal
/usr/local/nginx/sbin/nginx -s quit