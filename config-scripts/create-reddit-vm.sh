#!/bin/sh
yc compute instance create \
--name reddit-full \
--hostname reddit-full \
--cores=2 \
--core-fraction=20 \
--memory=2 \
--create-boot-disk image-folder-id=b1gge39opmve6qke1g0d,image-family=reddit-full,size=10GB \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--metadata serial-port-enable=1 \
--ssh-key ~/.ssh/appuser.pub
