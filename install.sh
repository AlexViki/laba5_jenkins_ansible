#!/bin/bash
sudo apt-get update && sudo apt-get install openjdk-8-jre -y
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update && sudo apt-get install jenkins -y
sudo apt-get -y install nginx
sudo echo 'shevchenko_47:$apr1$e21Mjpvo$756Sc/6hi2W2eCqWrMBvc.' > /etc/nginx/.htpasswd
sudo echo '' > /etc/nginx/sites-available/default
sudo echo 'server { 
				listen 80 default_server;
				root /var/www/html;
				index index.html index.htm index.nginx-debian.html;
				server_name _;
			location / {
				auth_basic "Access deny. Type your password";
				auth_basic_user_file /etc/nginx/.htpasswd;
				proxy_pass http://127.0.0.1:8080/;
				proxy_set_header Authorization "";
			}
		}'  > /etc/nginx/sites-available/default
sudo service nginx restart >> /tmp/install.log