#!/usr/bin/env bash

echo "172.28.128.10 node1" > /etc/hosts
echo "172.28.128.11 node2" >> /etc/hosts
echo "172.28.128.12 node3" >> /etc/hosts
echo "172.28.128.13 node4" >> /etc/hosts
echo "172.28.128.14 node5" >> /etc/hosts
yum -y install  net-tools.x86_64
yum -y install  vim gcc* openssl*
yum -y install centos-release-ansible-29.noarch && yum install ansible -y

