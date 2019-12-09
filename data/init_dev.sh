#!/bin/bash

set -eu -o pipefail

# development environment setup

# 1. timezone
sudo rm -v /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 2. install jdk krb5 client
sudo yum install -y curl gcc gcc-c++ git krb5-devel krb5-server krb5-workstation \
        make ntp ntpdate cmake lsof openssh-server redhat-lsb java-1.8.0-openjdk-devel \
        java-1.8.0-openjdk-src python-argparse

# CentOS repos don't contain ccache, so install from EPEL
sudo yum install -y epel-release
sudo yum install -y ccache

# Clean up yum caches
sudo yum clean all

# Download ant for centos
if [ ! -d /usr/local/apache-ant-1.9.14 ]; then

 sudo wget -nv \
  https://mirrors.tuna.tsinghua.edu.cn/apache/ant/binaries/apache-ant-1.9.14-bin.tar.gz
 sha512sum -c - <<< '487dbd1d7f678a92924ba884a57e910ccb4fe565c554278795a8fdfc80c4e88d81ebc2ccecb5a8f353f0b2076572bb921499a2cadb064e0f44fc406a3c31da20  apache-ant-1.9.14-bin.tar.gz'
 sudo tar -C /usr/local -xzf apache-ant-1.9.14-bin.tar.gz
 sudo ln -s /usr/local/apache-ant-1.9.14/bin/ant /usr/local/bin
fi

# Download maven for all OSes, since the OS-packaged version can be
# pretty old.
if [ ! -d /usr/local/apache-maven-3.5.4 ]; then
  sudo wget -cnv \
    https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
  sha512sum -c - <<< '2a803f578f341e164f6753e410413d16ab60fabe31dc491d1fe35c984a5cce696bc71f57757d4538fe7738be04065a216f3ebad4ef7e0ce1bb4c51bc36d6be86 apache-maven-3.5.4-bin.tar.gz'
  sudo tar -C /usr/local -xzf apache-maven-3.5.4-bin.tar.gz
  sudo ln -s /usr/local/apache-maven-3.5.4/bin/mvn /usr/local/bin
fi



