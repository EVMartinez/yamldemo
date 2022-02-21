FROM python:3.9-slim
ENV PYTHONUNBUFFERED 1

WORKDIR    /opt/oracle
RUN        apt-get update && apt-get -y install gcc && apt-get install -y libaio1 wget unzip \
            && wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip \
            && unzip instantclient-basiclite-linuxx64.zip \
            && rm -f instantclient-basiclite-linuxx64.zip \
            && cd /opt/oracle/instantclient* \
            && rm -f *jdbc* *occi* *mysql* *README *jar uidrvci genezi adrci \
            && echo /opt/oracle/instantclient* > /etc/ld.so.conf.d/oracle-instantclient.conf \
            && ldconfig && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/share/man/man1/

RUN pip install astapi==0.67.0
RUN pip install uvicorn==0.14.0
RUN pip install pydantic==1.8.2
RUN pip install cx-Oracle==7.3.0

RUN mkdir /code
WORKDIR /code

COPY ./codigo/ .