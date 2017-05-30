FROM debian:8
MAINTAINER Bilge <bilge@scriptfusion.com>

WORKDIR /root

# Install dependencies.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive\
    apt-get install -y build-essential libncurses5-dev rsync cpio python unzip bc wget

# Install Buildroot.
RUN wget -nv http://buildroot.uclibc.org/downloads/buildroot-2017.02.2.tar.bz2 &&\
    tar xf buildroot-*.tar* &&\
    rm buildroot-*.tar* &&\
    ln -s buildroot-* buildroot &&\
    mkdir -v buildroot/patches

# Create rootfs overlay.
RUN mkdir -vpm775 buildroot/rootfs_overlay/srv

# Install toolchain.
RUN wget -nv https://github.com/Docker-nano/crosstool-NG/releases/download/2.1.0/x86_64-nano-linux-uclibc.tar.xz &&\
    tar xf *.tar* &&\
    ln -s "$(tar tf *.tar* | head -1)" toolchain &&\
    rm *.tar*

# Install BusyBox.
RUN wget -nv https://busybox.net/downloads/busybox-1.26.2.tar.bz2 &&\
    tar xf *.tar* &&\
    rm *.tar* &&\
    ln -s busybox-* busybox &&\
    ln -s ~/busybox/.config /etc/busybox.conf

COPY    in/buildroot            /usr/local/bin/
COPY    in/buildroot-configure  /usr/local/bin/
COPY    in/busybox-configure    /usr/local/bin/
COPY    in/buildroot.conf       /root/buildroot/.config
COPY    in/post_build.sh        /root/buildroot/
COPY    in/busybox.conf         /root/busybox/.config

RUN echo "alias ll='ls -lah --color=auto'" >> .bashrc
