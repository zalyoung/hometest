#!/bin/bash

# Basic Configuration
echo "127.0.0.1 registry.devops.local" >> /etc/hosts

# Install JDK
java -version
if [ $? -eq 0 ]
then
        echo 'java existing'
else

yum -y install java-1.8.0-openjdk.x86_64
fi
# Insall Maven 


mvn
if [ $? -eq 0 ] 
then
        echo 'maven existing'
else
        yum -y install wget zip
        wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
        yum -y install apache-maven
        vers=`mvn -v`
        echo "maven install complete, version=$vers"
fi

docker version
if [ $? -eq 0 ]   
then
        echo 'docker existing'
else
        yum install -y yum-utils \
               device-mapper-persistent-data \
               lvm2
        yum-config-manager \
                --add-repo \
                https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
        yum install -y docker-ce
        systemctl start docker
        sed -i "s|ExecStart=/usr/bin/dockerd|ExecStart=/usr/bin/dockerd -H unix:///var/run/docker.sock -H 0.0.0.0:2375  --insecure-registry=registry.devops.local:5000 --registry-mirror=https://pee6w651.mirror.aliyuncs.com|g" /usr/lib/systemd/system/docker.service
        systemctl daemon-reload
        systemctl restart docker
        systemctl enable docker
fi

# Registry
mkdir -p /data/registry

docker run -d \
    --hostname registry.devops.local \
    --name registry \
    --publish 5000:5000 \
    --volume /data/registry:/var/lib/registry \
    --restart always \
    registry:2


# Jenkins
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y jenkins
systemctl enable jenkins
systemctl start jenkins

