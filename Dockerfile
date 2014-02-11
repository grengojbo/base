FROM ubuntu:12.04
MAINTAINER Gabriel Monroy <gabriel@opdemand.com>

ENV DEBIAN_FRONTEND noninteractive

# only the most important base packages
RUN apt-get install -yq ca-certificates net-tools sudo

# generate a local to suppress warnings
RUN locale-gen en_US.UTF-8

# install debug tools for use with lxc-attach
RUN apt-get install -yq vim strace lsof netcat

# download and extract latest stable etcdctl
ADD https://github.com/coreos/etcd/releases/download/v0.3.0/etcd-v0.3.0-linux-amd64.tar.gz /tmp
RUN cd /tmp && \
    mv etcd-v0.3.0-linux-amd64/etcdctl /usr/local/bin && \
    rm -rf etcd-v0.3.0-linux-amd64

# download and extract latest stable confd
ADD https://github.com/kelseyhightower/confd/releases/download/0.3.0-beta1/confd_0.3.0-beta1_linux_amd64.tar.gz /tmp
RUN ls -la /tmp
RUN cd /tmp && \
    mv confd /usr/local/bin && \
    rm -rf confd
