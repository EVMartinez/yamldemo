FROM alpine:latest

ENV http_proxy=http://10.51.158.200:3129
ENV https_proxy=http://10.51.158.200:3129

RUN env

## Instalar Propiedades
RUN apk update && apk upgrade && \ 
apk add --no-cache openjdk8 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community && \
apk add --no-cache maven --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community && \
apk add --no-cache git --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community && \
apk add --no-cache docker --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community 

#GIT
COPY .git-credentials /root/
RUN git config --global credential.helper store

# Maven
COPY settings.xml  /root/
ENV MAVEN_OPTS=-Djavax.net.ssl.trustStore=/root/.m2/TrustStore.jks

# Appdir
WORKDIR /usr/src/app

# Script compilador
COPY compile.sh  ./

# Certificados y Dockerfile
COPY Security/ca-chain_Azteca_cert.pem /usr/src/app/Security/
COPY Security-DevSecOps/TrustStore.jks /root/.m2/
COPY imagenDespliegueSRC/credito.Dockerfile /usr/src/app/Dockerfile/
COPY imagenDespliegueSRC/execute.sh /usr/src/app/Scripts/

# Ejecutor
CMD ["sh","compile.sh"]
