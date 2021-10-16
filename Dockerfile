# This dockerfile uses the ubuntu image
# VERSION 0 - EDITION 1
# Author:  Yen-Chin, Lee <yenchin@weintek.com>
# Command format: Instruction [arguments / command] ..

FROM ubuntu:20.04
MAINTAINER Yen-Chin, Lee, coldnew.tw@gmail.com
ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add 32bit package in package list
RUN dpkg --add-architecture i386

# Update package infos first
RUN apt-get update -y

## Install requred packages:
# http://www.yoctoproject.org/docs/current/ref-manual/ref-manual.html

# Essentials
RUN apt-get install -y make gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping vim bc g++-multilib bash locales zstd liblz4-tool \
     libncurses5-dev libncursesw5-dev zlib1g-dev gawk git gettext libssl-dev xsltproc rsync wget unzip python python2-minimal


# Set the locale, else yocto will complain
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8


# default workdir is /openwrt
WORKDIR /openwrt

# Add entry point, we use entrypoint.sh to mapping host user to
# container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
