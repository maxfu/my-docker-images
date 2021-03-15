#!/bin/sh

read -p "Enter Version: " version

echo "Starting to build image aapanel:$version"
docker build --rm -t xiaoyefu/aapanel:${version} .
