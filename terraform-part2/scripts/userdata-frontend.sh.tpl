#!/bin/bash
set -e

echo "export BACKEND_URL='${backend_url}'" >> /etc/environment
source /etc/environment

apt-get update -y
apt-get install -y nodejs npm git

cd /home/ubuntu
git clone https://github.com/KDMD/Docker-Assignment.git
chown -R ubuntu:ubuntu Docker-Assignment

cd Docker-Assignment/frontend
npm install

nohup node server.js > express.log 2>&1 &
