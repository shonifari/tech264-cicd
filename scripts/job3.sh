#!/bin/bash
EC2_USER=ubuntu
EC2_IP="3.250.154.185"

rsync -avz  -e "ssh -o StrictHostKeyChecking=no" app $EC2_USER@$EC2_IP:~/

ssh $EC2_USER@$EC2_IP << EOF
cd app
pm2 stop all
npm install
pm2 start app.js
EOF
