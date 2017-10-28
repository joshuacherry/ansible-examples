# vim: set ft=dockerfile:

FROM ubuntu:16.04
LABEL maintainer="Joshua Cherry"

# Color output.
ENV TERM=xterm

# Install dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
        software-properties-common \
        python-software-properties bash-completion \
        rsyslog systemd systemd-cron sudo \
        wget openssh-client openssh-server ufw kmod\
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN sed -i 's/^\($ModLoad imklog\)/#\1/' /etc/rsyslog.conf

COPY chef.asc /tmp/chef.asc
COPY chef-stable.list /etc/apt/sources.list.d/chef-stable.list

# Install Ansible
RUN apt-key add /tmp/chef.asc \
    && apt-add-repository ppa:ansible/ansible \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ansible=2.4.1.0-1* \
        git \
        sudo \
        inspec=1.43.5-1 \
        coreutils \
        net-tools \
        python-jmespath \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*