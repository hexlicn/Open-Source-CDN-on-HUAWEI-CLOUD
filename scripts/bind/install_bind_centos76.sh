#!/bin/bash

yum -y install bind bind-utils

systemctl start named
systemctl status named

# check bind configuration
named-checkconf
named-checkconf cdn.com /var/named/cdn.com.zone