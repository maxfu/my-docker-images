#!/bin/sh

read -p "Enter Version: " version

echo "Starting to build image baidunetdisk:$version"
sudo docker build --rm -t xiaoyefu/baidunetdisk:${version} .
