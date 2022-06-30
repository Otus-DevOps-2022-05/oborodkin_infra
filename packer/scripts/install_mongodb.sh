#!/bin/sh
apt-get install -y mongodb
systemctl start mongodb
systemctl enable mongodb
