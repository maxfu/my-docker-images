#!/bin/sh

read -p "Enter Image Name: " name

read -p "Enter Version: " version

echo "Starting to build image $name:$version"
sudo docker build --rm -t xiaoyefu/${name}:${version} .
