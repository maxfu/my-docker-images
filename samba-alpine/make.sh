#!/bin/sh

read -p "Enter Version: " version

echo "Starting to build image samba:$version"
sudo docker build --rm -t xiaoyefu/samba:${version} .
