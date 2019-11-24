FROM openjdk:8-jdk-alpine
#RUN adduser -g '' -D service_user

WORKDIR /src
COPY . /src

RUN mkdir /var/uav-recon
#RUN chown -R service_user /src
#RUN chown -R service_user /var/uav-recon

#USER service_user

RUN ./gradlew build -x test --info
RUN ls /src/build/libs

WORKDIR /var/uav-recon

RUN cp /src/build/libs/uav-recon-*.jar /var/uav-recon/app.jar
ENV JAVA_OPTS -XX:MaxMetaspaceSize=128m -Xmx2048m -XX:+UseG1GC -XX:+DisableExplicitGC -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/data/logs/ -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:/var/log/gc.log -XX:+UseGCLogFileRotation -XX:GCLogFileSize=512K -XX:NumberOfGCLogFiles=10 -Dmail.mime.charset=UTF-8 -Dspring.profiles.active=default
ENTRYPOINT exec java $JAVA_OPTS -jar /var/uav-recon/app.jar
EXPOSE 8080
