#!/bin/bash
set -e

echo "export MONGO_URL='${mongo_url}'" >> /etc/environment
source /etc/environment

apt-get update -y
apt-get install -y python3 python3-pip git

cd /home/ubuntu
git clone https://github.com/KDMD/Docker-Assignment.git
chown -R ubuntu:ubuntu Docker-Assignment

cd Docker-Assignment/backend
pip3 install -r requirements.txt

nohup python3 app.py > flask.log 2>&1 &
