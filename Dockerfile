FROM ubuntu:12.04
MAINTAINER Gabriel Monroy <gabriel@opdemand.com>

ENV DEBIAN_FRONTEND noninteractive

# upgrade base system packages
RUN apt-get update
RUN apt-get -yq upgrade

# only the most important base packages
RUN apt-get install -yq ca-certificates net-tools

# generate a local to suppress warnings
RUN locale-gen en_US.UTF-8

# install debug tools for use with lxc-attach
RUN apt-get install -yq vim strace lsof netcat

# download and extract latest stable etcdctl
ADD https://github.com/coreos/etcd/releases/download/v0.2.0/etcd-v0.2.0-Linux-x86_64.tar.gz /tmp/etcd.tar.gz
RUN cd /tmp && \
    tar xfz etcd.tar.gz && \
    mv etcd-v0.2.0-Linux-x86_64/etcdctl /usr/local/bin && \
    rm -rf etcd.tar.gz etcd-v0.2.0-Linux-x86_64

# download and extract latest stable confd
ADD https://github.com/kelseyhightower/confd/releases/download/0.3.0-beta1/confd_0.3.0-beta1_linux_amd64.tar.gz /tmp/confd.tar.gz
RUN mkdir -p /tmp/confd && cd /tmp/confd && \
    tar xfz ../confd.tar.gz && \
    mv confd /usr/local/bin && \
    rm -rf ../confd.tar confd