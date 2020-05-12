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

# Add ssh key
chmod 0600 $SSH_KEY_PATH
ssh-add -K $SSH_KEY_PATH


# Send run server script
echo "#!/bin/sh
cd $SERVER_PATH
npm install
export PORT=$FRONTEND_PORT
npm run start
" > run-frontend.sh

chmod +x run-frontend.sh
scp -P $SSH_PORT -i $SSH_KEY_PATH run-frontend.sh $SSH_HOST:$SERVER_PATH


# Send supervisor config
echo '[program:uav_recon_fr]
command=sh run-frontend.sh
directory=/opt/uav-recon-frontend/
autostart=true
autorestart=true
user=root
stdout_logfile=/var/log/uav_recon_fr_out.log
stderr_logfile=/var/log/uav_recon_fr_error.log
process_name=uav_recon_fr_00' > uav_recon_fr.conf

scp -P $SSH_PORT -i $SSH_KEY_PATH uav_recon_fr.conf $SSH_HOST:$SERVER_PATH
scp -P $SSH_PORT -i $SSH_KEY_PATH uav_recon_fr.conf $SSH_HOST:/etc/supervisor/conf.d


# Send server
scp -P $SSH_PORT -i $SSH_KEY_PATH -rp ./* $SSH_HOST:$SERVER_PATH

# Run server
ssh -i $SSH_KEY_PATH $SSH_HOST -p $SSH_PORT "supervisorctl stop uav_recon_fr:uav_recon_fr_00 && supervisorctl reread && supervisorctl update && supervisorctl restart uav_recon_fr:uav_recon_fr_00 && supervisorctl status"