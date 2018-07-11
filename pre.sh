#!/bin/bash
#hostnamectl set-hostname oc.boube.es  --static

# install updates
yum install -y update

# install the following base packages
yum install -y  wget git zile nano net-tools docker-1.13.1\
				bind-utils iptables-services \
				bridge-utils bash-completion \
				kexec-tools sos psacct openssl-devel \
				httpd-tools NetworkManager \
				python-cryptography python2-pip python-devel  python-passlib \
				java-1.8.0-openjdk-headless "@Development Tools"

#install epel
yum -y install epel-release

# Disable the EPEL repository globally so that is not accidentally used during later steps of the installation
sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo

yum -y install vim  wget git net-tools bind-utils iptables-services bridge-utils bash-completion pyOpenSSL docker

docker-storage-setup
sed "s/# INSECURE_REGISTRY=.*/INSECURE_REGISTRY='--selinux-enabled --insecure-registry 172.23.0.0\/16'/g" -i /etc/sysconfig/docker
systemctl enable docker
systemctl start docker


systemctl | grep "NetworkManager.*running" 
if [ $? -eq 1 ]; then
	systemctl start NetworkManager
	systemctl enable NetworkManager
fi
