# Data Recon Backend (SpringBoot)

## Running the application locally
The backend can be run locally by executing the following command in the terminal:

```shell
./gradlew bootRun
```

This will load the configuration file in `src/main/resources/application.yml`

Loading a custom file for local configuration, you need to specify the profile argument upon running:

```shell
./gradlew bootRun --args='--spring.profiles.active=local'
```

This will load the configuration file in `src/main/resources/application-local.yml`

## Building and deploying the application

To build a JAR file for deployment:

```shell
./gradlew build -x test --info
```

A build file will be created in `/src/build/libs`, specifically named `uav-recon-*.jar`

Running the JAR file:
```shell
java -XX:MaxMetaspaceSize=128m -Xmx7168m -XX:+UseG1GC -XX:+DisableExplicitGC -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/data/logs/ -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:/var/log/gc.log -XX:+UseGCLogFileRotation -XX:GCLogFileSize=512K -XX:NumberOfGCLogFiles=10 -Dmail.mime.charset=UTF-8 -Dspring.profiles.active=default -jar /var/uav-recon/uav-recon.jar
```

The whole build and deployment process are in the `Dockerfile`