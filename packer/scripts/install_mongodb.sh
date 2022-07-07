#!/bin/sh
apt-get install -y mongodb
sed -i 's/bind_ip = 127.0.0.1/bind_ip = 0.0.0.0/g' /etc/mongodb.conf
systemctl start mongodb
systemctl enable mongodb
