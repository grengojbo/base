# BeeGo APP base host
#
# VERSION               1.0.2

FROM ubuntu:14.04
MAINTAINER Gabriel Monroy <gabriel@opdemand.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y

# teh deps
RUN apt-get update && apt-get install -yq \
    make \
    ca-certificates \
    net-tools \
    sudo \
    wget \
    vim \
    strace \
    lsof \
    netcat mc curl \
    --no-install-recommends

ADD reverbrain.list /etc/apt/sources.list.d/reverbrain.list
RUN curl http://repo.reverbrain.com/REVERBRAIN.GPG | apt-key add -
RUN apt-get update && apt-get install -yq elliptics-client rift --no-install-recommends

RUN apt-get -y autoremove
RUN apt-get -y autoclean
RUN apt-get -y clean

# generate a local to suppress warnings
RUN locale-gen en_US.UTF-8

# download latest stable etcdctl
ADD https://s3-us-west-2.amazonaws.com/opdemand/etcdctl-v0.4.6 /usr/local/bin/etcdctl
RUN chmod +x /usr/local/bin/etcdctl

# install confd
ADD https://s3-us-west-2.amazonaws.com/opdemand/confd-v0.5.0-json /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd
