#!/bin/bash
whoami
sudo yum update
sudo yum install git -y
sudo git clone https://github.com/ananth-ms/jenkins_project.git
ls
cp -R jenkins_project/* .
sudo build acco_no.dkr.ecr.ap-south-1.amazonaws.com/jenkins_project
sudo aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin acco_no.dkr.ecr.ap-south-1.amazonaws.com
ls
sudo docker push acco_no.dkr.ecr.ap-south-1.amazonaws.com/jenkins_project
sudo docker run -d -p 80:80 acco_no.dkr.ecr.ap-south-1.amazonaws.com/jenkins_project
