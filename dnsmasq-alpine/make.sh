#!/bin/sh

read -p "Enter Version: " version

echo "Starting to build image dnsmasq:$version"
sudo docker build --rm -t xiaoyefu/dnsmasq:${version} .
