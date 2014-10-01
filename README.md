Buildroot container
===================

This is a [Docker](http://docker.com) container for [Buildroot](http://buildroot.uclibc.org) for building root file systems (rootfs). It was created to support the [Docker nano](https://github.com/Docker-nano) project.

Building
--------

To build the rootfs follow these steps.

1. `./build\ image` – Build the Docker image locally and tag as *buildroot*.
2. `./run\ container` – Removes any previous container started by this script and runs a new interactive container named *Buildroot* from the local *buildroot* image.
3. `buildroot-configure` – Configure Buildroot to install desired packages.
4. `buildroot` – Build new rootfs.
5. [Ctrl]+[D] – Exit container.
6. `./pull\ rootfs` – Copies the compressed rootfs tarball from the *Buildroot* container to the working directory.

Creating a Docker image
-----------------------

A rootfs tarball can be directly imported as a new Docker image using the following command, where *foo* is the name of the image.

`docker import - foo < rootfs.tar.xz`

The image can be run normally using a command similar to the following.

`docker run --rm foo /usr/bin/bar`

