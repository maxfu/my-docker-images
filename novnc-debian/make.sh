#!/bin/sh

read -p "Enter Version: " version

echo "Starting to build image downloader:$version"
sudo docker build --rm -t xiaoyefu/downloader:${version} .
