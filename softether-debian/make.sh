#!/bin/sh

read -p "Enter Version: " version

echo "Starting to build image sofether-vpnserver:$version"
sudo docker build --rm -t xiaoyefu/softether-vpnserver:${version} .
