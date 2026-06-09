#!/bin/bash
sudo yum update -y

#---------------git install ---------------

sudo yum install git -y


#-------java dependency for jenkins------------

sudo dnf install java-21-amazon-corretto -y

#------------jenkins install-------------
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "Initialization jenkins completed successfully."

# ------------------install terraform ------------------

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

echo "Initialization terraform completed successfully."

sudo dnf install mariadb105-server -y
#---------------------------Maven install -------------
sudo yum install maven -y

#---------------------------kubectl install ---------------
sudo curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin 

echo "Initialization k8s completed successfully."

# -----------------------------eksctl install--------------------------------
sudo curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

#---------------------------Helm install--------------------
#https://github.com/helm/helm/releases

wget https://get.helm.sh/helm-v3.6.0-linux-amd64.tar.gz

tar -zxvf helm-v3.6.0-linux-amd64.tar.gz

sudo mv linux-amd64/helm /usr/local/bin/helm

chmod 777 /usr/local/bin/helm  # give permissions

echo "Initialization helm completed successfully."

#------------------Docker install-------------
#sudo amazon-linux-extras install docker #linux 2022
sudo yum install docker -y #linux 2023
sudo usermod -aG docker ec2-user
sudo usermod -aG docker jenkins 
newgrp docker
sudo service docker start
sudo chmod 777 /var/run/docker.sock

echo "Initialization docker completed successfully."
#---------------------------trivy----------------
sudo rpm -ivh https://github.com/aquasecurity/trivy/releases/download/v0.48.3/trivy_0.48.3_Linux-64bit.rpm



#---------------------------ArgoCD----------------
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

#----------------Grafana Prometheus-------------------
helm repo add stable https://charts.helm.sh/stable
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
kubectl create namespace Prometheus
helm install stable prometheus-community/kube-prometheus-stack -n prometheus

echo "Initialization script completed successfully."