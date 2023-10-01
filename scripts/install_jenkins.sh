#!/bin/bash
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo dnf install -y java-11-amazon-corretto wget
sudo dnf install -y jenkins
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins
#sudo dnf install -y git
#sudo dnf install -y maven
#sudo amazon-linux-extras install -y ansible2
sleep 5
nohup sudo python3 -m http.server --directory /var/lib/jenkins/secrets/  80 &