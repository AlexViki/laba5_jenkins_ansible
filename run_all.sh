#!/bin/bash

echo "-------------START-------------"
echo "###########################################################"
echo "generate NEW SSH key"
echo "###########################################################"

sudo rm -rf /laba5/git_files
sudo mkdir -p /laba5/.ssh
sudo ssh-keygen -t rsa -N "" -f /laba5/.ssh/laba5_jenkins_to_ansible_to_azure <<< y
sudo chmod 600 /laba5/.ssh/*
sudo chown jenkins:jenkins /laba5/.ssh/*

echo "###########################################################"
echo "Install Azure CLI"
echo "###########################################################"

sudo curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

echo "###########################################################"
echo "Authorization to Azure"
echo "###########################################################"

az login --service-principal -u $URL -p $PASS --tenant $TENANT

echo "###########################################################"
echo "Installnstall ansible and ansible Azure module"
echo "###########################################################"

sudo apt-get update
sudo apt-get install -y libssl-dev libffi-dev python-dev python-pip
sudo pip install ansible
sudo pip install ansible[azure]

echo "###########################################################"
echo "Installnstall GIT"
echo "###########################################################"

sudo apt-get install git -y

echo "###########################################################"
echo "Clone playbook file from GIT"
echo "###########################################################"

sudo git clone https://github.com/AlexViki/laba5_jenkins_ansible.git /laba5/git_files

echo "###########################################################"
echo "RUN playbook "
echo "###########################################################"

ansible-playbook -i /laba5/git_files/hosts /laba5/git_files/create_vm.yml

echo "###########################################################"
echo
echo "-------------END-------------"
