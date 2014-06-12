FROM ubuntu:12.04
MAINTAINER Gabriel Monroy <gabriel@opdemand.com>

ENV DEBIAN_FRONTEND noninteractive

# only the most important base packages
RUN apt-get update && apt-get install -yq make ca-certificates net-tools sudo wget

# generate a local to suppress warnings
RUN locale-gen en_US.UTF-8

# install debug tools for use with lxc-attach
RUN apt-get install -yq vim strace lsof netcat

# download and extract latest stable etcdctl
ADD https://github.com/coreos/etcd/releases/download/v0.3.0/etcd-v0.3.0-linux-amd64.tar.gz /tmp/etcd.tar.gz
RUN cd /tmp && \
    tar xfz etcd.tar.gz && \
    mv etcd-v0.3.0-linux-amd64/etcdctl /usr/local/bin && \
    rm -rf etcd-v0.3.0-linux-amd64 etcd.tar.gz

# install confd
ADD https://s3-us-west-2.amazonaws.com/opdemand/confd-v0.4.1 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd
