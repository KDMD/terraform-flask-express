#!/bin/bash
set -e

LOG_FILE=/var/log/userdata.log
exec > >(tee -a $LOG_FILE) 2>&1

echo "===== Userdata started ====="

# ----------------------------
# Export environment variables
# ----------------------------
echo "export MONGO_URL='${mongo_url}'" >> /etc/environment
echo "export BACKEND_URL='${backend_url}'" >> /etc/environment
source /etc/environment

# ----------------------------
# System update
# ----------------------------
apt-get update -y

# ----------------------------
# Install Python & pip
# ----------------------------
apt-get install -y python3 python3-pip git

# ----------------------------
# Install Node.js (LTS)
# ----------------------------
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

# ----------------------------
# Clone application repo
# ----------------------------
cd /home/ubuntu
git clone https://github.com/KDMD/Docker-Assignment.git
chown -R ubuntu:ubuntu Docker-Assignment

# ----------------------------
# Backend – Flask
# ----------------------------
cd /home/ubuntu/Docker-Assignment/backend
pip3 install -r requirements.txt

# Start Flask on port 5000
nohup python3 app.py > flask.log 2>&1 &

# ----------------------------
# Frontend – Express
# ----------------------------
cd /home/ubuntu/Docker-Assignment/frontend

# If package.json exists, install dependencies
if [ -f package.json ]; then
  npm install
fi

# Start Express on port 3000
nohup node server.js > express.log 2>&1 &

echo "===== Userdata completed ====="
