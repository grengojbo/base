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
ADD https://github.com/coreos/etcd/releases/download/v0.4.2/etcd-v0.4.2-linux-amd64.tar.gz /tmp/etcd.tar.gz
RUN cd /tmp && \
    tar xfz etcd.tar.gz && \
    mv etcd-v0.4.2-linux-amd64/etcdctl /usr/local/bin && \
    rm -rf etcd-v0.4.2-linux-amd64 etcd.tar.gz

# download and extract latest stable confd
#RUN mkdir -p /tmp/confd
#ADD https://github.com/kelseyhightower/confd/releases/download/0.3.0-beta1/confd_0.3.0-beta1_linux_amd64.tar.gz /tmp/confd/confd.tar.gz
#RUN cd /tmp/confd && \
#    tar xfz confd.tar.gz && \
#    mv confd /usr/local/bin && \
#    rm -rf /tmp/confd

# install confd fork from https://github.com/gabrtv/confd (with iteration support)
RUN wget -q https://s3-us-west-2.amazonaws.com/deis/confd.bf9747a -O /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd
