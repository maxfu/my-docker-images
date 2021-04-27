#!/bin/sh

read -p "Enter Version: " version

echo "Starting to build image kodi:$version"
sudo docker build --rm -t xiaoyefu/kodi:${version} .
