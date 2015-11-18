Buildroot container
===================

[![Build Status][Build image]][Build]

This is a [Docker](http://docker.com) container for [Buildroot](http://buildroot.uclibc.org) for building root file
systems (rootfs). It was created to support the [Docker nano](https://github.com/Docker-nano) project.

The configuration for this repository builds an empty rootfs because it is intended to serve as a template for your own
configurations. Get started building your own product by cloning the [template](https://github.com/Docker-nano/template)
repository.

Building
--------

To build the rootfs follow these steps.

 1. `./nano build` – Build the Docker image locally and tag as *buildroot*.
 2. `./nano run` – Removes any previous container started by this script and runs a new interactive container named
    *Buildroot* from the local *buildroot* image.
 3. `buildroot-configure` – Configure Buildroot to install desired packages.
 4. `buildroot` – Build new rootfs.
 5. [Ctrl]+[D] – Exit container.
 6. `./nano pull rootfs` – Copies the compressed rootfs tarball from the *Buildroot* container to the working directory.
 7. `./nano pull config` – Copies the Buildroot configuration if changes have been made.

Creating a Docker image
-----------------------

A rootfs tarball can be directly imported as a new Docker image using the following command, where *foo* is the name of
the image.

`docker import - foo < rootfs.tar.xz`

The image can be run normally using a command similar to the following.

`docker run -it foo /usr/bin/bar`

  [Build]: http://travis-ci.org/Docker-nano/Buildroot
  [Build image]: http://img.shields.io/travis/Docker-nano/Buildroot.svg "Build status"
  
Note on Windows/Cygwin
-----------------------
You might find yourself with strange formatting and non-usability of the ncurses interface when running `buildroot-configure` through a cygwin console on VirtualBox (maybo on others, too). Just entering the VirtualBox console directly and entering with `docker run <NAME> && docker exec -ti <NAME> bash` and then execute within the container `buildroot-configure` does the trick for this step.
