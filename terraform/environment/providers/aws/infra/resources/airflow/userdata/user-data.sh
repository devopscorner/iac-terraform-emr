#!/bin/sh

#### User Data ####
sudo yum update
sudo yum install -y tmux git vim python3

python3 -m pip install pip==21.3.1
pip3 install --upgrade pip cffi

pip3 install --no-cache-dir \
    PyYaml \
    Jinja2 \
    httplib2 \
    six \
    requests \
    boto3 \
    awscli

## Set Locale
echo 'LANG=en_US.utf-8' >> /etc/environment
echo 'LC_ALL=en_US.utf-8' >> /etc/environment

## Environment Installation
git clone https://github.com/devopscorner/scripts.git /home/ec2-user/scripts
cd scripts/installer

## Using Container
sh install_docker.sh
sh install_docker_airflow.sh

## Without Container
# sh install_airflow.sh