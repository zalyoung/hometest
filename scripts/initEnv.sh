#!/bin/bash
echo "139.198.189.208 registry.devops.local" >> /etc/hosts 

yum install -y zip \
               yum-utils \
               device-mapper-persistent-data \
               lvm2
yum-config-manager \
        --add-repo \
        https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

yum install -y docker-ce
sed -i "s|ExecStart=/usr/bin/dockerd|ExecStart=/usr/bin/dockerd -H unix:///var/run/docker.sock -H tcp://0.0.0.0:2375 --registry-mirror=https://pee6w651.mirror.aliyuncs.com --insecure-registry=registry.devops.local:5000 |g" /usr/lib/systemd/system/docker.service
systemctl daemon-reload
systemctl restart docker
systemctl enable docker

docker pull maven:3.5.2-jdk-8-alpine
docker pull nginx:1.13.6-alpine
docker pull tomcat:9.0.1-jre8-alpine

cp post-commit ../.git/hooks/.
