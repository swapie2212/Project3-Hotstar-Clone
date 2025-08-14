#!/bin/bash

# -----------------------------------------------
# Install Terraform
# -----------------------------------------------
sudo apt-get update -y
sudo apt-get install wget gpg -y

# Add HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add HashiCorp repository to apt sources
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

# Install Terraform
sudo apt-get update -y
sudo apt-get install terraform -y

# -----------------------------------------------
# Install kubectl (Kubernetes CLI)
# -----------------------------------------------
sudo apt-get update -y
sudo apt-get install curl -y

# Download latest stable kubectl binary
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Install kubectl to system path
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Verify kubectl installation
kubectl version --client

# -----------------------------------------------
# Install AWS CLI v2
# -----------------------------------------------
# Download AWS CLI zip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Install unzip if not already installed
sudo apt-get install unzip -y

# Extract and install AWS CLI
unzip awscliv2.zip
sudo ./aws/install

# Verify AWS CLI installation
aws --version
