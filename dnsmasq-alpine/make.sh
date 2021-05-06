#!/bin/sh

version="3.0"

echo "Starting to build image dnsmasq:$version"
sudo docker build --rm -t xiaoyefu/dnsmasq:${version} .
