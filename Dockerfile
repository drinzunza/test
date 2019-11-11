FROM openjdk:8-jdk-alpine
WORKDIR /src
COPY . /src
RUN ./gradlew build
RUN ls /src/build/libs
#FROM openjdk:8-jre as server
#RUN apt-get update && apt-get -y install libreoffice-writer
RUN mkdir /var/uav-recon
WORKDIR /var/uav-recon
RUN cp /src/build/libs/uav-recon-*.jar /var/uav-recon/app.jar
ENV JAVA_OPTS -XX:MaxMetaspaceSize=128m -Xmx2048m -XX:+UseG1GC -XX:+DisableExplicitGC -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/data/logs/ -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:/var/log/gc.log -XX:+UseGCLogFileRotation -XX:GCLogFileSize=512K -XX:NumberOfGCLogFiles=10 -Dmail.mime.charset=UTF-8 -Dspring.profiles.active=default
ENTRYPOINT exec java $JAVA_OPTS -jar /var/uav-recon/app.jar
EXPOSE 8080
