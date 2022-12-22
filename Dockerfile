FROM openjdk:8-jdk-alpine
#RUN adduser -g '' -D service_user

ARG SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/uav_recon
ARG SPRING_DATASOURCE_USERNAME=postgres
ARG SPRING_DATASOURCE_PASSWORD=docker

WORKDIR /src
COPY . /src

RUN mkdir /var/uav-recon
#RUN chown -R service_user /src
#RUN chown -R service_user /var/uav-recon

#USER service_user
ENV SPRING_DATASOURCE_URL=$SPRING_DATASOURCE_URL
ENV SPRING_DATASOURCE_USERNAME=$SPRING_DATASOURCE_USERNAME
ENV SPRING_DATASOURCE_PASSWORD=$SPRING_DATASOURCE_PASSWORD

RUN ./gradlew build -x test --info
RUN ls /src/build/libs

WORKDIR /var/uav-recon
EXPOSE 8080
RUN cp /src/build/libs/uav-recon-*.jar /var/uav-recon/app.jar
ENV JAVA_OPTS -XX:MaxMetaspaceSize=128m -Xmx2048m -XX:+UseG1GC -XX:+DisableExplicitGC -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/data/logs/ -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:/var/log/gc.log -XX:+UseGCLogFileRotation -XX:GCLogFileSize=512K -XX:NumberOfGCLogFiles=10 -Dmail.mime.charset=UTF-8 -Dspring.profiles.active=default
ENTRYPOINT exec java $JAVA_OPTS -jar /var/uav-recon/app.jar
