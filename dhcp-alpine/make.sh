#!/bin/sh

read -p "Enter Version: " version

echo "Starting to build image dhcpd:$version"
sudo docker build --rm -t xiaoyefu/dhcpd:${version} .
