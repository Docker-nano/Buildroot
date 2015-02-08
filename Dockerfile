FROM debian:6
MAINTAINER Bilge <bilge@scriptfusion.com>

WORKDIR	/root

# Install dependencies.
RUN	apt-get update && DEBIAN_FRONTEND=noninteractive\
	apt-get install -y build-essential libncurses5-dev rsync cpio python unzip bc wget

# Install Buildroot.
RUN	wget -nv http://buildroot.uclibc.org/downloads/buildroot-2014.11.tar.bz2 &&\
	tar xf buildroot-*.tar* &&\
	rm buildroot-*.tar* &&\
	ln -s buildroot-* buildroot &&\
	mkdir -v buildroot/patches

# Create rootfs overlay.
RUN mkdir -vpm775 buildroot/rootfs_overlay/srv

# Install toolchain.
RUN	wget -nv --no-check-certificate \
	https://github.com/Docker-nano/crosstool-NG/releases/download/1.0.1/x86_64-nano-linux-uclibc.tar.xz &&\
	tar xf *.tar* &&\
	ln -s "$(tar tf *.tar* | head -1)" toolchain &&\
	rm *.tar*

COPY	in/buildroot		/usr/local/bin/
COPY	in/buildroot-configure	/usr/local/bin/
COPY	in/buildroot.conf	/root/buildroot/.config
COPY	in/post_build.sh	/root/buildroot/
