FROM  registry.access.redhat.com/ubi8/openjdk-8
MAINTAINER usrdocker
USER root
#ENV JAVA_HOME=/usr/java/openjdk-12
ENV TZ=America/Mexico_City
COPY /security/* $JAVA_HOME/lib/security/
RUN cd $JAVA_HOME/lib/security & ls -ltr $JAVA_HOME/lib/security/
RUN keytool -importcert -noprompt -trustcacerts -alias brms -file $JAVA_HOME/lib/security/ca-chain_Azteca_cert.pem -storepass changeit -keystore $JAVA_HOME/lib/security/cacerts
#RUN keytool -importcert -noprompt -trustcacerts -alias rancher -file $JAVA_HOME/lib/security/ca-chain.cert.pem -storepass changeit -keystore $JAVA_HOME/lib/security/cacerts
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

#ENVIRONMENT -> Selector de Ambientes

ENTRYPOINT ["java", "-jar","-Dspring.profiles.active=$(ENVIRONMENT)", "app.jar", "--server.port=8080"]