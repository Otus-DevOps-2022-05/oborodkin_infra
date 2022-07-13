#!/bin/sh

echo $( yc compute instance list --folder-id $FOLDER_ID --format json | jq 'map( { (if .name == "reddit-app" then "app" elif .name == "reddit-db" then "db"  else empty end | tostring): {hosts: [.network_interfaces[0].primary_v4_address.one_to_one_nat.address]} } ) | add')
