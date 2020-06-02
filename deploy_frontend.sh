#!/bin/sh

# Develop
HOST="34.70.68.149"
# Production
#HOST="34.69.177.31"
# Staging
#HOST="35.223.226.173"

# Do not change below

SSH_HOST="cicd_man@$HOST"
SSH_PORT="522"
SSH_KEY_PATH=".ssh/cicd_rsa"
SERVER_PATH="/opt/uav-recon-frontend/"
FRONTEND_PORT="8080"

# Build fontend
yarn build

# Add ssh key
chmod 0600 $SSH_KEY_PATH
ssh-add -K $SSH_KEY_PATH


# Send frontend files
ssh -i $SSH_KEY_PATH $SSH_HOST -p $SSH_PORT "rm -rf $SERVER_PATH && mkdir $SERVER_PATH"
scp -P $SSH_PORT -i $SSH_KEY_PATH -rp ./build/* $SSH_HOST:$SERVER_PATH
