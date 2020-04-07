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
SSH_KEY_PATH="ssh/cicd_rsa"
SERVER_PATH="/opt/uav-recon/"
BUILD_NAME="uav-recon-0.0.1.jar"
ARTEFACT_PATH="build/libs/$BUILD_NAME"
JAVA_OPTS="-XX:MaxMetaspaceSize=128m -Xmx1048m -XX:+UseG1GC -XX:+DisableExplicitGC -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/opt/logs/ -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:/var/log/gc.log -XX:+UseGCLogFileRotation -XX:GCLogFileSize=512K -XX:NumberOfGCLogFiles=10 -Dmail.mime.charset=UTF-8 -Dspring.profiles.active=default -Dserver.port=80 -Duav.server.host=http://$HOST"

# Build server
rm -rf build
./gradlew bootJar

# Add ssh key
chmod 0600 $SSH_KEY_PATH
ssh-add -K $SSH_KEY_PATH

# Send run server script
echo '#!/bin/sh
APP_IDS=$(pgrep -f "java -XX:MaxMetaspaceSize")
if [ -n "${APP_IDS}" ]; then
    echo "Killed $APP_IDS"
    kill -9 $APP_IDS
fi
' > run-server.sh

echo "java $JAVA_OPTS -jar $SERVER_PATH$BUILD_NAME" >> run-server.sh

chmod +x run-server.sh
scp -P $SSH_PORT -i $SSH_KEY_PATH run-server.sh $SSH_HOST:$SERVER_PATH


# Send supervisor config
echo '[program:uav_recon_sv]
command=sh run-server.sh
directory=/opt/uav-recon/
autostart=true
autorestart=true
user=root
stdout_logfile=/var/log/uav_recon_sv_out.log
stderr_logfile=/var/log/uav_recon_sv_error.log
process_name=%%(program_name)s_%%(process_num)02d' > uav_recon_sv.conf

scp -P $SSH_PORT -i $SSH_KEY_PATH uav_recon_sv.conf $SSH_HOST:$SERVER_PATH
scp -P $SSH_PORT -i $SSH_KEY_PATH uav_recon_sv.conf $SSH_HOST:/etc/supervisor/conf.d


# Send server
scp -P $SSH_PORT -i $SSH_KEY_PATH $ARTEFACT_PATH $SSH_HOST:$SERVER_PATH


# Run server
ssh -i $SSH_KEY_PATH $SSH_HOST -p $SSH_PORT "supervisorctl stop all && supervisorctl reread && supervisorctl update && supervisorctl restart all && supervisorctl status"