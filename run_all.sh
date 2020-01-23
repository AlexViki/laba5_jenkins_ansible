#!/bin/bash

URL=`cat ~/secret/url`
PASS=`cat ~/secret/pass`
TENANT=`cat ~/secret/tenant`

echo "-------------START-------------"
echo "###########################################################"
echo "generate NEW SSH key"
echo "###########################################################"

ssh-keygen -t rsa -N "" -f ~/.ssh/jenkins_to_ansible_azure

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

git clone https://github.com/AlexViki/laba5_jenkins_ansible.git /tmp/laba5

echo "###########################################################"
echo "RUN playbook "
echo "###########################################################"

ansible-playbook -i /tmp/laba5/hosts /tmp/laba5/create_vm.yml

echo "###########################################################"
echo
echo "-------------END-------------"
