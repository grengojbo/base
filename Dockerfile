FROM ubuntu:12.04
MAINTAINER Gabriel Monroy <gabriel@opdemand.com>

ENV DEBIAN_FRONTEND noninteractive

# only the most important base packages
RUN apt-get update && apt-get install -yq make ca-certificates net-tools sudo wget

# generate a local to suppress warnings
RUN locale-gen en_US.UTF-8

# install debug tools for use with lxc-attach
RUN apt-get install -yq vim strace lsof netcat

# download latest stable etcdctl
ADD https://s3-us-west-2.amazonaws.com/opdemand/etcdctl-v0.4.4 /usr/local/bin/etcdctl
RUN chmod +x /usr/local/bin/etcdctl

# install confd
ADD https://s3-us-west-2.amazonaws.com/opdemand/confd-v0.4.1 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd
