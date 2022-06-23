#!/bin/sh
sudo apt-get install -y mongodb
sudo systemctl start mongodb
sudo systemctl enable mongodb
