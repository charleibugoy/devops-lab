#!/bin/bash

yum update -y

# Core tools
yum install -y git unzip curl jq tar

# Docker
yum install -y docker
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user

# AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o aws.zip
unzip aws.zip
./aws/install

# Terraform
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum install -y terraform

# kubectl (EKS compatible)
curl -o kubectl https://s3.amazonaws.com/amazon-eks/1.29.0/2023-11-14/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin/

# Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Node.js
curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs

# k6 load testing
yum install -y https://dl.k6.io/rpm/repo.rpm
yum install -y k6

mkdir -p /home/ec2-user/devops-lab
chown -R ec2-user:ec2-user /home/ec2-user/devops-lab