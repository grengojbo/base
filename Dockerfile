# BeeGo APP base host
#
# VERSION               1.1.0

FROM ubuntu:14.04
MAINTAINER Gabriel Monroy <gabriel@opdemand.com>

ENV DEBIAN_FRONTEND noninteractive

# teh deps
RUN apt-get update && apt-get upgrade -y && apt-get update && apt-get install -yq \
    make \
    ca-certificates \
    net-tools \
    sudo \
    wget \
    vim \
    strace \
    lsof \
    netcat mc curl \
    --no-install-recommends && apt-get -y autoremove && apt-get -y autoclean && apt-get -y clean

ADD reverbrain.list /etc/apt/sources.list.d/reverbrain.list
RUN curl http://repo.reverbrain.com/REVERBRAIN.GPG | apt-key add - \
    && apt-get update && apt-get install -yq elliptics-client rift --no-install-recommends \
    && --no-install-recommends && apt-get -y autoremove && apt-get -y autoclean && apt-get -y clean
    
# generate a local to suppress warnings
RUN locale-gen en_US.UTF-8

# download latest stable etcdctl
ADD https://s3-us-west-2.amazonaws.com/opdemand/etcdctl-v0.4.6 /usr/local/bin/etcdctl
RUN chmod +x /usr/local/bin/etcdctl

# install confd
ADD https://s3-us-west-2.amazonaws.com/opdemand/confd-v0.5.0-json /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd
