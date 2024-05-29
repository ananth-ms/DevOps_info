#!/bin/bash
whoami
sudo yum update
sudo yum install git -y
sudo git clone https://github.com/ananth-ms/jenkins_project.git
ls
cp -R jenkins_project/* .
sudo build 590184013243.dkr.ecr.ap-south-1.amazonaws.com/jenkins_project
sudo aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 590184013243.dkr.ecr.ap-south-1.amazonaws.com
ls
sudo docker push 590184013243.dkr.ecr.ap-south-1.amazonaws.com/jenkins_project
sudo docker run -d -p 80:80 590184013243.dkr.ecr.ap-south-1.amazonaws.com/jenkins_project
