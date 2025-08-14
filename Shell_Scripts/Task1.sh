#!/bin/bash

#-------------------------
# Update server
#-------------------------
sudo apt update -y
sudo apt upgrade -y

#-------------------------
# Install prerequisites
#-------------------------
sudo apt install -y wget curl gnupg apt-transport-https ca-certificates software-properties-common

#-------------------------
# Java (Temurin 17) installation
#-------------------------
sudo mkdir -p /etc/apt/keyrings
wget -O- https://packages.adoptium.net/artifactory/api/gpg/key/public \
  | sudo tee /etc/apt/keyrings/adoptium.asc > /dev/null

echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(. /etc/os-release && echo "$VERSION_CODENAME") main" \
  | sudo tee /etc/apt/sources.list.d/adoptium.list > /dev/null

sudo apt update -y
sudo apt install -y temurin-17-jdk
java -version

#-------------------------
# Jenkins installation
#-------------------------
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key \
  | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install -y jenkins net-tools
sudo systemctl enable jenkins
sudo systemctl start jenkins

#-------------------------
# Docker installation
#-------------------------
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker ubuntu
newgrp docker

echo "✅ Installation completed: Java 17, Jenkins, and Docker are ready."
