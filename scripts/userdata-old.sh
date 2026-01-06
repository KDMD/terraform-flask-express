```bash
#!/bin/bash


export MONGO_URL="${mongo_url}"
export BACKEND_URL="${backend_url}"


apt-get update -y


# Install Python & pip
apt-get install -y python3 python3-pip
pip3 install flask flask-cors pymongo


# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs


# ---------------- FLASK BACKEND ----------------
mkdir -p /opt/backend
cat <<EOF > /opt/backend/app.py
from flask import Flask, request, jsonify
from pymongo import MongoClient
from flask_cors import CORS
import os


MONGO_URL = os.getenv("MONGO_URL")


app = Flask(__name__)
CORS(app)
client = MongoClient(MONGO_URL)
db = client["FirstDB"]
collection = db["record"]


@app.route('/api/data', methods=['POST'])
def form():
data = request.get_json()
name = data.get('name')
email = data.get('email')


if not name or not email:
return jsonify({"error": "All fields are required."}), 400


collection.insert_one({'name': name, 'email': email})
return jsonify({"message": f"Data saved for {name} with email {email}"}), 200


app.run(host='0.0.0.0', port=5000)
EOF


nohup python3 /opt/backend/app.py &


# ---------------- EXPRESS FRONTEND ----------------
mkdir -p /opt/frontend
cd /opt/frontend
npm init -y
npm install express body-parser axios


cat <<EOF > /opt/frontend/server.js
const express = require('express');
const bodyParser = require('body-parser');
const axios = require('axios');
const app = express();
const port = 3000;


app.use(bodyParser.urlencoded({ extended: true }));
nohup node /opt/frontend/server.js &