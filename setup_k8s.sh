#!/usr/bin/env bash

# vbox
echo 'deb https://download.virtualbox.org/virtualbox/debian xenial contrib' | sudo tee /etc/apt/sources.list.d/virtualbox.list
curl -s https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add -
curl -s https://www.virtualbox.org/download/oracle_vbox.asc | sudo apt-key add -
sudo apt update
sudo apt install virtualbox-5.2

# docker
echo 'deb https://download.docker.com/linux/ubuntu zesty stable' | sudo tee /etc/apt/source.list.d/docker.list
curl -s https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt update
sudo apt install docker-ce
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# k8s
echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt update
sudo apt install -y kubelet kubeadm kubectl minikube docker.io


