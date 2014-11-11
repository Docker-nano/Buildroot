#!/bin/bash

cd ~

# Install dependencies.
apt-get update && DEBIAN_FRONTEND=noninteractive\
	apt-get install -y build-essential libncurses5-dev rsync cpio python unzip bc wget

# Install Buildroot.
wget -nv http://buildroot.uclibc.org/downloads/buildroot-2014.08.tar.bz2 &&\
	tar xf buildroot-*.tar* &&\
	rm buildroot-*.tar* &&\
	ln -s buildroot-* buildroot &&\
	mkdir -v buildroot/patches

# Create rootfs overlay.
mkdir -vpm775 buildroot/rootfs_overlay/srv

# Install toolchain.
wget -nv --no-check-certificate \
	https://github.com/Docker-nano/crosstool-NG/releases/download/1.0.1/x86_64-nano-linux-uclibc.tar.xz &&\
	tar xf *.tar* &&\
	ln -s "$(tar tf *.tar* | head -1)" toolchain &&\
	rm *.tar*

cd -

cp	in/buildroot			/usr/local/bin/
cp	in/buildroot.conf		~/buildroot/.config
cp	in/post_build.sh		~/buildroot
