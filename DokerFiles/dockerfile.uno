FROM redhat/ubi8

RUN yum update -y
RUN yum install -y git
RUN yum install -y gcc
RUN yum install -y gcc-c++
RUN yum install -y kernel-headers make
RUN yum install -y yum-utils
RUN yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
RUN yum install -y openssl-devel

COPY cmake-3.20.5 ./cmake-3.20.5

RUN chmod +x cmake-3.20.5/bootstrap
RUN sh cmake-3.20.5/bootstrap && make &&  make install
RUN  cmake --version
RUN yum install -y iptables
RUN yum install -y docker-ce docker-ce-cli containerd.io
RUN yum install -y python3.8
RUN yum install -y python3-pip

RUN pip3 install --user gunicorn
RUN pip3 install --user  zeep
RUN pip3 install --user  flask
RUN pip3 install --user  injector
RUN pip3 install --user  flask_cors
RUN pip3 install --user  uvicorn
RUN pip3 install --user  pymssql
RUN pip3 install --user  pandas
RUN pip3 install --user  jupyterthemes
RUN pip3 install --user  matplotlib
RUN pip3 install --user  numpy
RUN pip3 install --user  seaborn
RUN pip3 install --user  scipy
RUN pip3 install --user  sklearn

RUN pip3 install --user  xgboost

WORKDIR /usr/src/app

